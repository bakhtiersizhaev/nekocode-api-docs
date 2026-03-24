# ============================================================================
# Nekocode API Gateway — Interactive Setup Script (PowerShell)
# Works on: Windows (native PowerShell 5.1+)
# Author: Bakhtier Sizhaev (@bakhtiersizhaev)
# License: MIT
# ============================================================================

param(
    [switch]$Install,
    [switch]$Remove,
    [switch]$Help
)

$Version = "1.0.0"

function Write-Banner {
    Write-Host ""
    Write-Host "  +==========================================+" -ForegroundColor Cyan
    Write-Host "  |       NEKOCODE API GATEWAY SETUP         |" -ForegroundColor Cyan
    Write-Host "  |       https://nekocode.app               |" -ForegroundColor Cyan
    Write-Host "  |       v$Version                             |" -ForegroundColor Cyan
    Write-Host "  +==========================================+" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Info  { param($m) Write-Host "[i] $m" -ForegroundColor Cyan }
function Write-Ok    { param($m) Write-Host "[+] $m" -ForegroundColor Green }
function Write-Warn  { param($m) Write-Host "[!] $m" -ForegroundColor Yellow }
function Write-Err   { param($m) Write-Host "[x] $m" -ForegroundColor Red }

$Gateways = @(
    @{ Name = "Default (Global)"; Host = "gateway.nekocode.app" },
    @{ Name = "Russia (Primary)"; Host = "ru.gateway.nekocode.app" },
    @{ Name = "Russia #2"; Host = "ru-2.gateway.nekocode.app" },
    @{ Name = "Russia #3"; Host = "ru-3.gateway.nekocode.app" }
)

$Channels = @(
    @{ Name = "Alpha (x0.3 price, recommended)"; Path = "alpha" },
    @{ Name = "Spark (x1, 1M context)"; Path = "spark" }
)

function Select-One {
    param($Prompt, $Options)
    Write-Host ""
    Write-Host $Prompt -ForegroundColor White
    for ($i = 0; $i -lt $Options.Count; $i++) {
        Write-Host "  $($i+1)) $($Options[$i].Name)" -ForegroundColor Cyan
    }
    do {
        $choice = Read-Host "  >"
        $idx = [int]$choice - 1
    } while ($idx -lt 0 -or $idx -ge $Options.Count)
    return $idx
}

function Detect-Tools {
    Write-Info "Scanning for AI tools..."
    $tools = @()
    if (Get-Command claude -ErrorAction SilentlyContinue) { $tools += "Claude Code"; Write-Ok "Claude Code" }
    if (Get-Command codex -ErrorAction SilentlyContinue) { $tools += "Codex CLI"; Write-Ok "Codex CLI" }
    if (Get-Command opencode -ErrorAction SilentlyContinue) { $tools += "OpenCode"; Write-Ok "OpenCode" }
    if (Get-Command aider -ErrorAction SilentlyContinue) { $tools += "Aider"; Write-Ok "Aider" }
    if (Test-Path "$env:LOCALAPPDATA\Programs\cursor") { $tools += "Cursor"; Write-Ok "Cursor" }
    if ($tools.Count -eq 0) { Write-Warn "No AI tools detected" }
    else { Write-Info "Found $($tools.Count) tools" }
    return $tools
}

function Test-Connection {
    param($BaseUrl, $ApiKey)
    Write-Info "Testing connection..."
    try {
        $body = '{"model":"claude-haiku-4-5","max_tokens":1,"messages":[{"role":"user","content":"hi"}]}'
        $headers = @{
            "x-api-key" = $ApiKey
            "anthropic-version" = "2023-06-01"
            "content-type" = "application/json"
        }
        $resp = Invoke-WebRequest -Uri "$BaseUrl/v1/messages" -Method POST -Headers $headers -Body $body -UseBasicParsing
        Write-Ok "Connection successful! (HTTP $($resp.StatusCode))"
    } catch {
        $code = $_.Exception.Response.StatusCode.value__
        if ($code -eq 401) { Write-Err "Invalid API key (HTTP 401)" }
        elseif ($code -eq 429) { Write-Warn "Rate limited (HTTP 429) but connection works" }
        else { Write-Err "Connection failed: $($_.Exception.Message)" }
    }
}

function Do-Install {
    $apiKey = Read-Host "Enter Nekocode API key (sk_live_...)"
    if (-not $apiKey.StartsWith("sk_live_")) {
        Write-Err "Invalid key format. Must start with sk_live_"
        return
    }
    Write-Ok "API key accepted"

    $gwIdx = Select-One "Select gateway:" $Gateways
    $gwHost = $Gateways[$gwIdx].Host

    $chIdx = Select-One "Select channel:" $Channels
    $channel = $Channels[$chIdx].Path

    $baseUrl = "https://$gwHost/$channel"
    Write-Info "Base URL: $baseUrl"

    $tools = Detect-Tools

    Write-Host ""
    Write-Host "Configuration snippets:" -ForegroundColor White
    Write-Host ""
    Write-Host "--- Claude Code (~/.claude/settings.json) ---" -ForegroundColor Yellow
    Write-Host @"
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "$apiKey",
    "ANTHROPIC_BASE_URL": "$baseUrl",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
"@
    Write-Host ""
    Write-Host "--- Terminal env vars ---" -ForegroundColor Yellow
    Write-Host "`$env:ANTHROPIC_BASE_URL = `"$baseUrl`""
    Write-Host "`$env:ANTHROPIC_AUTH_TOKEN = `"$apiKey`""

    Write-Host ""
    $doTest = Read-Host "Test connection? [Y/n]"
    if ($doTest -ne "n") { Test-Connection $baseUrl $apiKey }

    Write-Host ""
    Write-Ok "Setup complete!"
    Write-Host "  Docs:    https://github.com/bakhtiersizhaev/nekocode-api-docs"
    Write-Host "  Support: https://t.me/nekocode_app"
}

function Do-Remove {
    Write-Info "To revert, remove Nekocode env vars:"
    Write-Host '  Remove-Item Env:\ANTHROPIC_BASE_URL -ErrorAction SilentlyContinue'
    Write-Host '  Remove-Item Env:\ANTHROPIC_AUTH_TOKEN -ErrorAction SilentlyContinue'
    Write-Host '  Remove-Item Env:\OPENAI_BASE_URL -ErrorAction SilentlyContinue'
    Write-Host ""
    Write-Info "For Claude Code: remove env block from ~/.claude/settings.json"
    Write-Info "For Codex CLI: delete ~/.config/codex/config.toml"
}

function Show-Help {
    Write-Host "Nekocode API Gateway Setup v$Version"
    Write-Host ""
    Write-Host "Usage: .\setup.ps1 [-Install] [-Remove] [-Help]"
    Write-Host ""
    Write-Host "  -Install  Configure Nekocode (default)"
    Write-Host "  -Remove   Revert to standard config"
    Write-Host "  -Help     Show this help"
}

# Main
Write-Banner
if ($Help) { Show-Help; return }
if ($Remove) { Do-Remove; return }
Do-Install
