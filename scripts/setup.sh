#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# Nekocode API Gateway — Interactive Setup Script
# Works on: macOS, Linux, WSL
# Author: Bakhtier Sizhaev (@bakhtiersizhaev)
# License: MIT
# ============================================================================

VERSION="1.0.0"

# --- Colors ---
if [[ -t 1 ]] && command -v tput &>/dev/null && [[ $(tput colors 2>/dev/null || echo 0) -ge 8 ]]; then
  RED=$(tput setaf 1); GREEN=$(tput setaf 2); YELLOW=$(tput setaf 3)
  CYAN=$(tput setaf 6); BOLD=$(tput bold); RESET=$(tput sgr0)
else
  RED=""; GREEN=""; YELLOW=""; CYAN=""; BOLD=""; RESET=""
fi

# --- Helpers ---
info()  { echo "${CYAN}[i]${RESET} $*"; }
ok()    { echo "${GREEN}[+]${RESET} $*"; }
warn()  { echo "${YELLOW}[!]${RESET} $*"; }
err()   { echo "${RED}[x]${RESET} $*" >&2; }
banner() {
  echo ""
  echo "${CYAN}${BOLD}  ╔══════════════════════════════════════════╗${RESET}"
  echo "${CYAN}${BOLD}  ║       NEKOCODE API GATEWAY SETUP         ║${RESET}"
  echo "${CYAN}${BOLD}  ║       https://nekocode.app               ║${RESET}"
  echo "${CYAN}${BOLD}  ║       v${VERSION}                             ║${RESET}"
  echo "${CYAN}${BOLD}  ╚══════════════════════════════════════════╝${RESET}"
  echo ""
}

# --- OS Detection ---
detect_os() {
  case "$(uname -s)" in
    Darwin*)  OS="macos" ;;
    Linux*)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        OS="wsl"
      else
        OS="linux"
      fi ;;
    MINGW*|MSYS*|CYGWIN*) OS="windows" ;;
    *) OS="unknown" ;;
  esac
  info "OS: ${BOLD}${OS}${RESET}"
}

# --- Gateway URLs ---
GATEWAYS=(
  "Default (Global)|gateway.nekocode.app"
  "Russia (Primary)|ru.gateway.nekocode.app"
  "Russia #2|ru-2.gateway.nekocode.app"
  "Russia #3|ru-3.gateway.nekocode.app"
)

CHANNELS=(
  "Alpha (x0.3 price, recommended)|alpha"
  "Spark (x1, 1M context)|spark"
)

# --- Tool Detection ---
DETECTED_TOOLS=()
TOOL_NAMES=()

detect_tools() {
  info "Scanning for AI tools..."
  DETECTED_TOOLS=()
  TOOL_NAMES=()

  # Claude Code
  if command -v claude &>/dev/null || [[ -d "$HOME/.claude" ]]; then
    DETECTED_TOOLS+=("claude-code")
    TOOL_NAMES+=("Claude Code")
    ok "Claude Code"
  fi

  # Codex CLI
  if command -v codex &>/dev/null; then
    DETECTED_TOOLS+=("codex-cli")
    TOOL_NAMES+=("Codex CLI (OpenAI)")
    ok "Codex CLI"
  fi

  # OpenCode
  if command -v opencode &>/dev/null; then
    DETECTED_TOOLS+=("opencode")
    TOOL_NAMES+=("OpenCode")
    ok "OpenCode"
  fi

  # Aider
  if command -v aider &>/dev/null; then
    DETECTED_TOOLS+=("aider")
    TOOL_NAMES+=("Aider")
    ok "Aider"
  fi

  # Cursor
  if [[ -d "/Applications/Cursor.app" ]] || [[ -d "$HOME/.cursor" ]]; then
    DETECTED_TOOLS+=("cursor")
    TOOL_NAMES+=("Cursor IDE")
    ok "Cursor IDE"
  fi

  # Windsurf
  if [[ -d "/Applications/Windsurf.app" ]] || [[ -d "$HOME/.windsurf" ]]; then
    DETECTED_TOOLS+=("windsurf")
    TOOL_NAMES+=("Windsurf IDE")
    ok "Windsurf IDE"
  fi

  # Continue.dev
  if [[ -d "$HOME/.continue" ]]; then
    DETECTED_TOOLS+=("continue-dev")
    TOOL_NAMES+=("Continue.dev")
    ok "Continue.dev"
  fi

  # OpenClaw
  if command -v openclaw &>/dev/null || [[ -d "$HOME/.openclaw" ]]; then
    DETECTED_TOOLS+=("openclaw")
    TOOL_NAMES+=("OpenClaw")
    ok "OpenClaw"
  fi

  if [[ ${#DETECTED_TOOLS[@]} -eq 0 ]]; then
    warn "No AI tools detected. You can still get config snippets."
  else
    info "Found ${BOLD}${#DETECTED_TOOLS[@]}${RESET} tools"
  fi
}

# --- Menu helpers ---
choose_one() {
  local prompt="$1"; shift
  local -a options=("$@")
  echo ""
  echo "${BOLD}${prompt}${RESET}"
  for i in "${!options[@]}"; do
    local label="${options[$i]%%|*}"
    echo "  ${CYAN}$((i+1))${RESET}) ${label}"
  done
  while true; do
    read -rp "  > " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      CHOSEN_IDX=$((choice - 1))
      return 0
    fi
    err "Invalid choice. Enter 1-${#options[@]}"
  done
}

choose_multi() {
  local prompt="$1"; shift
  local -a options=("$@")
  echo ""
  echo "${BOLD}${prompt}${RESET}"
  echo "  (enter numbers separated by spaces, or ${CYAN}a${RESET} for all)"
  for i in "${!options[@]}"; do
    echo "  ${CYAN}$((i+1))${RESET}) ${options[$i]}"
  done
  while true; do
    read -rp "  > " choices
    CHOSEN_MULTI=()
    if [[ "$choices" == "a" || "$choices" == "A" ]]; then
      for i in "${!options[@]}"; do CHOSEN_MULTI+=("$i"); done
      return 0
    fi
    local valid=true
    for c in $choices; do
      if [[ "$c" =~ ^[0-9]+$ ]] && (( c >= 1 && c <= ${#options[@]} )); then
        CHOSEN_MULTI+=("$((c-1))")
      else
        err "Invalid: $c"; valid=false; break
      fi
    done
    $valid && return 0
  done
}

# --- Backup ---
backup_file() {
  local f="$1"
  if [[ -f "$f" ]]; then
    cp "$f" "${f}.bak.$(date +%Y%m%d%H%M%S)"
    info "Backed up: ${f}"
  fi
}

# --- Tool configs: INSTALL ---
install_claude_code() {
  local settings="$HOME/.claude/settings.json"
  mkdir -p "$HOME/.claude"
  backup_file "$settings"

  if [[ -f "$settings" ]]; then
    # Check if env key exists, add/replace
    if grep -q '"env"' "$settings" 2>/dev/null; then
      # Replace env block using python if available, else warn
      if command -v python3 &>/dev/null; then
        python3 -c "
import json, sys
with open('$settings') as f: d = json.load(f)
d.setdefault('env', {})
d['env']['ANTHROPIC_AUTH_TOKEN'] = '$API_KEY'
d['env']['ANTHROPIC_BASE_URL'] = '$BASE_URL'
d['env']['CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC'] = '1'
with open('$settings', 'w') as f: json.dump(d, f, indent=2)
"
      else
        warn "python3 not found. Manual edit required for $settings"
        echo "  Add to env: ANTHROPIC_AUTH_TOKEN, ANTHROPIC_BASE_URL=$BASE_URL"
        return
      fi
    else
      if command -v python3 &>/dev/null; then
        python3 -c "
import json
with open('$settings') as f: d = json.load(f)
d['env'] = {
  'ANTHROPIC_AUTH_TOKEN': '$API_KEY',
  'ANTHROPIC_BASE_URL': '$BASE_URL',
  'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC': '1'
}
with open('$settings', 'w') as f: json.dump(d, f, indent=2)
"
      else
        warn "python3 not found. Please add env vars manually to $settings"
        return
      fi
    fi
  else
    cat > "$settings" << CEOF
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "$API_KEY",
    "ANTHROPIC_BASE_URL": "$BASE_URL",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
CEOF
  fi
  ok "Claude Code configured: $settings"
}

install_codex_cli() {
  local confdir="$HOME/.config/codex"
  local conf="$confdir/config.toml"
  mkdir -p "$confdir"
  backup_file "$conf"

  cat > "$conf" << CEOF
# Nekocode Gateway for Codex CLI
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "${BASE_URL}/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
CEOF

  # Add env var to shell rc
  local rc="$HOME/.zshrc"
  [[ -f "$HOME/.bashrc" ]] && ! [[ -f "$HOME/.zshrc" ]] && rc="$HOME/.bashrc"
  if ! grep -q "NEKOCODE_API_KEY" "$rc" 2>/dev/null; then
    echo "" >> "$rc"
    echo "# Nekocode API Key (added by setup.sh)" >> "$rc"
    echo "export NEKOCODE_API_KEY=\"$API_KEY\"" >> "$rc"
  fi
  ok "Codex CLI configured: $conf"
  info "Run: ${BOLD}source $rc && codex --provider nekocode${RESET}"
}

install_opencode() {
  local conf="opencode.json"
  backup_file "$conf"
  cat > "$conf" << CEOF
{
  "\$schema": "https://opencode.ai/config.json",
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "$API_KEY",
        "baseURL": "${BASE_URL}/v1",
        "headers": {
          "anthropic-beta": "claude-code-20250219,interleaved-thinking-2025-05-14,fine-grained-tool-streaming-2025-05-14,adaptive-thinking-2026-01-28"
        }
      }
    }
  }
}
CEOF
  ok "OpenCode configured: $(pwd)/$conf"
}

install_aider() {
  local rc="$HOME/.zshrc"
  [[ -f "$HOME/.bashrc" ]] && ! [[ -f "$HOME/.zshrc" ]] && rc="$HOME/.bashrc"
  backup_file "$rc"

  if ! grep -q "ANTHROPIC_API_BASE.*nekocode" "$rc" 2>/dev/null; then
    cat >> "$rc" << CEOF

# Nekocode for Aider (added by setup.sh)
export ANTHROPIC_API_KEY="$API_KEY"
export ANTHROPIC_API_BASE="$BASE_URL"
CEOF
  fi
  ok "Aider configured in $rc"
  info "Run: ${BOLD}source $rc && aider --model claude-sonnet-4-6${RESET}"
}

install_openclaw() {
  echo ""
  warn "OpenClaw requires manual config edit."
  info "Add to ${BOLD}~/.openclaw/openclaw.json${RESET}:"
  echo ""
  cat << CEOF
  "models": {
    "mode": "merge",
    "providers": {
      "nekocode": {
        "baseUrl": "$BASE_URL",
        "apiKey": "$API_KEY",
        "api": "anthropic-messages",
        "models": [
          {"id": "claude-opus-4-6", "name": "Opus 4.6 Nekocode", "reasoning": true, "input": ["text","image"], "contextWindow": 200000, "maxTokens": 16384},
          {"id": "claude-sonnet-4-6", "name": "Sonnet 4.6 Nekocode", "reasoning": true, "input": ["text","image"], "contextWindow": 200000, "maxTokens": 16384},
          {"id": "claude-haiku-4-5", "name": "Haiku 4.5 Nekocode", "reasoning": false, "input": ["text","image"], "contextWindow": 200000, "maxTokens": 8192}
        ]
      }
    }
  }
CEOF
}

install_generic() {
  local tool_name="$1"
  echo ""
  warn "${tool_name}: see docs/integrations/ for configuration guide"
  info "Base URL: ${BOLD}$BASE_URL${RESET}"
  info "API Key:  ${BOLD}$API_KEY${RESET}"
}

# --- Tool configs: REMOVE ---
remove_claude_code() {
  local settings="$HOME/.claude/settings.json"
  if [[ -f "$settings" ]] && command -v python3 &>/dev/null; then
    backup_file "$settings"
    python3 -c "
import json
with open('$settings') as f: d = json.load(f)
env = d.get('env', {})
for k in ['ANTHROPIC_AUTH_TOKEN', 'ANTHROPIC_BASE_URL', 'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC']:
    env.pop(k, None)
d['env'] = env
with open('$settings', 'w') as f: json.dump(d, f, indent=2)
"
    ok "Claude Code reverted"
  else
    warn "Cannot auto-revert Claude Code. Remove ANTHROPIC_BASE_URL from $settings"
  fi
}

remove_codex_cli() {
  local conf="$HOME/.config/codex/config.toml"
  if [[ -f "$conf" ]]; then
    backup_file "$conf"
    rm "$conf"
    ok "Codex CLI config removed"
  fi
  info "Also remove NEKOCODE_API_KEY from your shell rc file"
}

remove_opencode() {
  if [[ -f "opencode.json" ]]; then
    backup_file "opencode.json"
    cat > "opencode.json" << 'CEOF'
{
  "$schema": "https://opencode.ai/config.json"
}
CEOF
    ok "OpenCode reverted to default"
  fi
}

remove_aider() {
  local rc="$HOME/.zshrc"
  [[ -f "$HOME/.bashrc" ]] && ! [[ -f "$HOME/.zshrc" ]] && rc="$HOME/.bashrc"
  warn "Remove Nekocode lines from $rc manually (search for 'Nekocode for Aider')"
}

# --- Test connection ---
test_connection() {
  echo ""
  info "Testing connection to Nekocode..."
  local resp
  resp=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "x-api-key: $API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "content-type: application/json" \
    -d '{"model":"claude-haiku-4-5","max_tokens":1,"messages":[{"role":"user","content":"hi"}]}' \
    "${BASE_URL}/v1/messages" 2>/dev/null || echo "000")

  case "$resp" in
    200) ok "Connection successful! (HTTP 200)" ;;
    401) err "Invalid API key (HTTP 401)" ;;
    429) warn "Rate limited (HTTP 429) — but connection works" ;;
    000) err "Connection failed — check network/gateway" ;;
    *)   warn "HTTP $resp — check docs/troubleshooting.md" ;;
  esac
}

# --- Main: Install ---
do_install() {
  # API Key
  echo ""
  read -rp "${BOLD}Enter Nekocode API key (sk_live_...): ${RESET}" API_KEY
  if [[ ! "$API_KEY" =~ ^sk_live_ ]]; then
    err "Invalid key format. Must start with sk_live_"
    exit 1
  fi
  ok "API key accepted"

  # Gateway
  choose_one "Select gateway:" "${GATEWAYS[@]}"
  local gw_host="${GATEWAYS[$CHOSEN_IDX]#*|}"
  ok "Gateway: $gw_host"

  # Channel
  choose_one "Select channel:" "${CHANNELS[@]}"
  local channel="${CHANNELS[$CHOSEN_IDX]#*|}"
  ok "Channel: $channel"

  BASE_URL="https://${gw_host}/${channel}"
  info "Base URL: ${BOLD}$BASE_URL${RESET}"

  # Detect tools
  detect_tools

  if [[ ${#DETECTED_TOOLS[@]} -gt 0 ]]; then
    choose_multi "Select tools to configure:" "${TOOL_NAMES[@]}"

    echo ""
    info "Configuring selected tools..."
    for idx in "${CHOSEN_MULTI[@]}"; do
      local tool="${DETECTED_TOOLS[$idx]}"
      echo ""
      info "--- ${TOOL_NAMES[$idx]} ---"
      case "$tool" in
        claude-code)   install_claude_code ;;
        codex-cli)     install_codex_cli ;;
        opencode)      install_opencode ;;
        aider)         install_aider ;;
        openclaw)      install_openclaw ;;
        cursor)        install_generic "Cursor" ;;
        windsurf)      install_generic "Windsurf" ;;
        continue-dev)  install_generic "Continue.dev" ;;
      esac
    done
  fi

  # Test
  echo ""
  read -rp "Test connection? [Y/n]: " do_test
  [[ "$do_test" != "n" && "$do_test" != "N" ]] && test_connection

  # Summary
  echo ""
  echo "${GREEN}${BOLD}  Setup complete!${RESET}"
  echo "  Gateway:  $gw_host"
  echo "  Channel:  $channel"
  echo "  Base URL: $BASE_URL"
  echo ""
  echo "  Docs:     https://github.com/bakhtiersizhaev/nekocode-api-docs"
  echo "  Support:  https://t.me/nekocode_app"
  echo "  Status:   https://status.nekocode.app"
  echo ""
}

# --- Main: Remove ---
do_remove() {
  info "Scanning for Nekocode configs..."
  local found=()
  local fnames=()

  [[ -f "$HOME/.claude/settings.json" ]] && grep -q "nekocode\|ANTHROPIC_BASE_URL" "$HOME/.claude/settings.json" 2>/dev/null && found+=("claude-code") && fnames+=("Claude Code")
  [[ -f "$HOME/.config/codex/config.toml" ]] && grep -q "nekocode" "$HOME/.config/codex/config.toml" 2>/dev/null && found+=("codex-cli") && fnames+=("Codex CLI")
  [[ -f "opencode.json" ]] && grep -q "nekocode" "opencode.json" 2>/dev/null && found+=("opencode") && fnames+=("OpenCode")
  grep -q "nekocode\|ANTHROPIC_API_BASE.*gateway" "$HOME/.zshrc" "$HOME/.bashrc" 2>/dev/null && found+=("aider") && fnames+=("Aider (shell rc)")

  if [[ ${#found[@]} -eq 0 ]]; then
    info "No Nekocode configs found."
    return
  fi

  choose_multi "Select tools to revert:" "${fnames[@]}"
  for idx in "${CHOSEN_MULTI[@]}"; do
    local tool="${found[$idx]}"
    echo ""
    info "Reverting ${fnames[$idx]}..."
    case "$tool" in
      claude-code) remove_claude_code ;;
      codex-cli)   remove_codex_cli ;;
      opencode)    remove_opencode ;;
      aider)       remove_aider ;;
    esac
  done

  echo ""
  ok "Revert complete. Tools restored to default configuration."
}

# --- Help ---
show_help() {
  echo "Nekocode API Gateway Setup v${VERSION}"
  echo ""
  echo "Usage: $0 [options]"
  echo ""
  echo "Options:"
  echo "  --install    Run install mode (default)"
  echo "  --remove     Run remove/revert mode"
  echo "  --help       Show this help"
  echo ""
  echo "Website:  https://nekocode.app"
  echo "Docs:     https://github.com/bakhtiersizhaev/nekocode-api-docs"
  echo "Telegram: https://t.me/nekocode_app"
}

# --- Entry ---
main() {
  banner
  detect_os

  case "${1:-}" in
    --help|-h)    show_help; exit 0 ;;
    --remove|-r)  do_remove; exit 0 ;;
    --install|-i) do_install; exit 0 ;;
    "")
      choose_one "What do you want to do?" \
        "Install Nekocode|install" \
        "Remove Nekocode (revert)|remove"
      case "$CHOSEN_IDX" in
        0) do_install ;;
        1) do_remove ;;
      esac
      ;;
    *) err "Unknown option: $1"; show_help; exit 1 ;;
  esac
}

main "$@"
