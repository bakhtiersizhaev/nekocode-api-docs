---
name: nekocode-gateway
description: "Configure Nekocode AI Gateway for any CLI/IDE tool. Supports Claude Code, Codex CLI, OpenCode, OpenClaw, Cursor, Aider, Windsurf, Continue.dev."
metadata:
  author: "Bakhtier Sizhaev (@bakhtiersizhaev)"
  version: "1.0.0"
  updated: "2026-03-24"
  source: "https://github.com/bakhtiersizhaev/nekocode-api-docs"
---

# Nekocode AI Gateway — Configuration Skill

## What is Nekocode

Nekocode is a unified AI gateway available at https://nekocode.app. It provides a single API key that grants access to both Anthropic Claude and OpenAI GPT model families through a unified endpoint. This eliminates the need to manage separate API keys and billing accounts for each provider.

- **Website**: https://nekocode.app
- **Telegram Bot**: @nekocode_app
- **Status Page**: @nekocode_status / https://status.nekocode.app
- **Key format**: `sk_live_...`

---

## Gateways

Multiple gateway endpoints are available for geographic optimization and redundancy:

| Name      | URL                          | Region |
|-----------|------------------------------|--------|
| Default   | `gateway.nekocode.app`       | Global |
| Russia    | `ru.gateway.nekocode.app`    | Russia |
| Russia 2  | `ru-2.gateway.nekocode.app`  | Russia |
| Russia 3  | `ru-3.gateway.nekocode.app`  | Russia |

All gateways support HTTPS. Use the gateway closest to your location for lowest latency. If one gateway is unresponsive, switch to another.

---

## Channels

Nekocode offers two pricing channels appended to the gateway URL path:

### Alpha Channel (`/alpha`)

- **Price multiplier**: x0.3 (70% discount vs direct API pricing)
- **Context window**: 200K tokens
- **Models**: All Anthropic Claude + OpenAI GPT models
- **Best for**: Development, testing, cost-sensitive production workloads

### Spark Channel (`/spark`)

- **Price multiplier**: x1 (standard pricing)
- **Context window**: 1M tokens for Claude `[1m]` model variants
- **Models**: Anthropic Claude only
- **Best for**: Long-context workloads requiring full 1M token window

---

## Models — Alpha Channel

### Anthropic Models (Alpha)

| Model | Input ($/M tok) | Output ($/M tok) | Cache Write ($/M tok) | Cache Read ($/M tok) | Speed (tok/s) | Latency |
|-------|:---:|:---:|:---:|:---:|:---:|:---:|
| `claude-opus-4-6` | 5 | 25 | 6.25 | 0.5 | 37.9 | 5.1s |
| `claude-opus-4-6[1m]` | 5 | 25 | 6.25 | 0.5 | 39.7 | 4.8s |
| `claude-sonnet-4-6` | 3 | 15 | 3.75 | 0.3 | 20.7 | 3.5s |
| `claude-sonnet-4-6[1m]` | 3 | 15 | 3.75 | 0.3 | 23.1 | 8.5s |
| `claude-haiku-4-5` | 1 | 5 | 1.25 | 0.1 | 60.7 | 2.9s |
| `claude-sonnet-4-5` | 3 | 15 | 3.75 | 0.3 | 47.0 | 2.4s |
| `claude-opus-4-5` | 5 | 25 | 6.25 | 0.5 | 48.6 | 3.4s |

### OpenAI Models (Alpha)

| Model | Input ($/M tok) | Output ($/M tok) | Cache Write ($/M tok) | Cache Read ($/M tok) | Speed (tok/s) | Latency |
|-------|:---:|:---:|:---:|:---:|:---:|:---:|
| `gpt-5` | 1.07 | 8.5 | 0 | 0.11 | - | - |
| `gpt-5-mini` | 0.25 | 2 | 0 | 0.03 | 74.0 | 16.7s |
| `gpt-5-codex` | 1.25 | 10 | 0 | 0.13 | - | - |
| `gpt-5.1` | 1.25 | 10 | 0 | 0.13 | - | - |
| `gpt-5.1-codex` | 1.25 | 10 | 0 | 0.13 | - | - |
| `gpt-5.2` | 1.75 | 14 | 0 | 0.17 | - | - |
| `gpt-5.2-codex` | 1.75 | 14 | 0 | 0.17 | - | - |
| `gpt-5.3-codex` | 1.74 | 14 | 0 | 0.17 | 37.5 | 2.3s |
| `gpt-5.4` | 2.5 | 15 | 0 | 0.25 | 24.1 | 28.7s |

---

## Models — Spark Channel

Spark channel supports Anthropic models only. The `[1m]` variants have different pricing to support 1M token context windows.

| Model | Input ($/M tok) | Output ($/M tok) | Cache Write ($/M tok) | Cache Read ($/M tok) | Speed (tok/s) | Latency |
|-------|:---:|:---:|:---:|:---:|:---:|:---:|
| `claude-opus-4-6` | 5 | 25 | 6.25 | 0.5 | 32.7 | 3.9s |
| `claude-opus-4-6[1m]` | 10 | 37.5 | 12.5 | 1 | 37.2 | 5.8s |
| `claude-sonnet-4-6` | 3 | 15 | 3.75 | 0.3 | 36.5 | 3.1s |
| `claude-sonnet-4-6[1m]` | 6 | 22.5 | 7.5 | 0.6 | 39.6 | 4.7s |
| `claude-haiku-4-5` | 1 | 5 | 1.25 | 0.1 | 44.0 | 2.5s |
| `claude-sonnet-4-5` | 3 | 15 | 3.75 | 0.3 | - | - |
| `claude-opus-4-5` | 5 | 25 | 6.25 | 0.5 | - | - |

---

## Configuration — Claude Code

Add the following environment variables to `~/.claude/settings.json`:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_your_api_key",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

- `ANTHROPIC_AUTH_TOKEN` — your Nekocode API key (starts with `sk_live_`)
- `ANTHROPIC_BASE_URL` — gateway URL with channel path (no trailing `/v1`)
- `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` — disables telemetry and non-essential requests

**To revert**: remove the three environment variables from the `env` object in `~/.claude/settings.json`.

---

## Configuration — Codex CLI

Set environment variables before running Codex:

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha/v1"
export OPENAI_API_KEY="sk_live_your_api_key"
```

Or configure via `~/.config/codex/config.toml` with a custom provider:

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

**To revert**: unset the environment variables (`unset OPENAI_BASE_URL OPENAI_API_KEY`) and remove the `[model_providers.nekocode]` section from `config.toml`.

---

## Configuration — OpenCode

Add a provider to `opencode.json`:

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "sk_live_your_api_key",
        "baseURL": "https://gateway.nekocode.app/alpha/v1",
        "headers": {
          "anthropic-beta": "claude-code-20250219,interleaved-thinking-2025-05-14,fine-grained-tool-streaming-2025-05-14,adaptive-thinking-2026-01-28"
        }
      }
    }
  }
}
```

**IMPORTANT**: The `baseURL` value MUST end with `/v1`. Omitting the `/v1` suffix will cause connection errors.

**To revert**: remove the `provider` section from `opencode.json`.

---

## Configuration — OpenClaw

Add Nekocode as a provider in `openclaw.json`:

```json
{
  "models": {
    "providers": {
      "nekocode": {
        "api": "anthropic-messages",
        "apiUrl": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_your_api_key"
      }
    },
    "fallbacks": [
      "nekocode/claude-sonnet-4-6",
      "nekocode/claude-opus-4-6"
    ]
  }
}
```

Models are referenced as `nekocode/<model-id>` in the fallbacks array.

**To revert**: remove the `nekocode` entry from `providers` and remove `nekocode/*` entries from `fallbacks`.

---

## Configuration — Cursor

1. Open Cursor Settings
2. Navigate to **Models** > **Override Anthropic Base URL**
3. Set the base URL to: `https://gateway.nekocode.app/alpha`
4. Set the API key to your `sk_live_...` key

**To revert**: clear the Override Anthropic Base URL and API key fields in Cursor settings.

---

## Configuration — Aider

Set environment variables:

```bash
export ANTHROPIC_API_KEY="sk_live_your_api_key"
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
```

Or pass inline via flag:

```bash
aider --api-base anthropic=https://gateway.nekocode.app/alpha
```

**To revert**: unset the environment variables (`unset ANTHROPIC_API_KEY ANTHROPIC_API_BASE`).

---

## Configuration — Windsurf

1. Open Windsurf Settings
2. Navigate to **AI Provider** > **Custom endpoint**
3. Set the endpoint URL to: `https://gateway.nekocode.app/alpha`
4. Set the API key to your `sk_live_...` key

**To revert**: reset the AI Provider settings to default.

---

## Configuration — Continue.dev

Add a model entry to `~/.continue/config.json`:

```json
{
  "models": [
    {
      "title": "Claude via Nekocode",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    }
  ]
}
```

**To revert**: remove the Nekocode model entry from the `models` array.

---

## Configuration — Anthropic SDK

### Python

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha"
)

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello"}]
)
```

### TypeScript

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic({
  apiKey: "sk_live_your_api_key",
  baseURL: "https://gateway.nekocode.app/alpha",
});

const message = await client.messages.create({
  model: "claude-sonnet-4-6",
  max_tokens: 1024,
  messages: [{ role: "user", content: "Hello" }],
});
```

**To revert**: remove the `base_url` / `baseURL` parameter from the constructor call.

---

## Configuration — cURL

### Anthropic-style (Claude models)

```bash
curl -X POST https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

### OpenAI-style (GPT models)

```bash
curl -X POST https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

---

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| HTTP 429 (Too Many Requests) | Rate limit hit on current gateway | Switch to a different gateway endpoint, or wait and retry |
| Network errors from Russia | Default gateway may be unreachable | Use `ru.gateway.nekocode.app`, `ru-2.gateway.nekocode.app`, or `ru-3.gateway.nekocode.app` |
| "Invalid API key" error | Key format is wrong | Verify the key starts with `sk_live_` prefix |
| "Model not found" error | Incorrect model identifier | Check the exact model ID from the tables above (case-sensitive) |
| OpenCode connection error | Missing `/v1` suffix in base URL | Ensure `baseURL` ends with `/v1` (e.g., `https://gateway.nekocode.app/alpha/v1`) |
| High latency / slow responses | Suboptimal gateway or channel | Try the Alpha channel for lower latency; use the geographically closest gateway |
| Claude Code not using gateway | Env vars not loaded | Restart Claude Code after editing `~/.claude/settings.json` |
| Spark `[1m]` models unavailable | Using Alpha channel | Switch to Spark channel (`/spark`) for 1M context variants |
