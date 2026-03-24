# Nekocode API Gateway — AI Reference

Updated: 2026-03-24
Source: https://nekocode.app
Telegram: https://t.me/nekocode_app
Status: https://status.nekocode.app
Dashboard: https://nekocode.app/dashboard

## WHAT

Unified AI gateway proxy for Anthropic Claude and OpenAI GPT models. Single API key, multiple gateways, two pricing channels. Drop-in replacement for direct provider APIs.

## AUTH

Key format: `sk_live_...`
Get key: https://nekocode.app/dashboard/api-keys
Key shown once — save immediately. If lost, revoke and create new.

| API | Header |
|-----|--------|
| Anthropic | `x-api-key: {key}` |
| OpenAI | `Authorization: Bearer {key}` |

## GATEWAYS

| Gateway | Base URL | Region | Uptime |
|---------|----------|--------|--------|
| Default | `gateway.nekocode.app` | Global (EU/US) | 99.96% |
| Russia | `ru.gateway.nekocode.app` | Russia | 99.94% |
| Russia #2 | `ru-2.gateway.nekocode.app` | Russia | 99.99% |
| Russia #3 | `ru-3.gateway.nekocode.app` | Russia | 99.96% |

URL pattern: `https://{gateway}/{channel}`

## API ENDPOINTS

Three distinct API endpoints per channel:

| Endpoint | Path | Auth Header | Models | API Format |
|----------|------|-------------|--------|------------|
| Anthropic Messages | `/{channel}/v1/messages` | `x-api-key: sk_live_...` | All Claude | Anthropic Messages API |
| OpenAI Chat Completions | `/{channel}/v1/chat/completions` | `Authorization: Bearer sk_live_...` | GPT-5, GPT-5-mini, GPT-5.1, GPT-5.2, GPT-5.4 | OpenAI Chat Completions |
| OpenAI Responses | `/{channel}/v1/responses` | `Authorization: Bearer sk_live_...` | gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex | OpenAI Responses API |

CRITICAL:
- Codex models ONLY work via `/v1/responses`. Using `/v1/chat/completions` returns `model_not_found`.
- `max_output_tokens` for Codex must be >= 16.
- GPT and Codex models available ONLY on Alpha channel. Spark returns 400/500.
- Claude models work via ALL three endpoints (Messages API recommended).

## CHANNELS

| Channel | URL suffix | Price multiplier | Context | Models |
|---------|-----------|-----------------|---------|--------|
| Alpha | `/alpha` | x0.3 (70% off) | 200K | Anthropic + OpenAI |
| Spark | `/spark` | x1 | up to 1M | Anthropic only |

Spark `[1m]` model variants cost x2 base price for 1M context window.

## MODELS — ALPHA

Prices: USD per 1M tokens. Alpha channel (x0.3 multiplier).

### Anthropic Claude

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.8 | 4.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 38.3 | 5.2s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 24.1 | 3.8s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 9.6 | 9.3s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 74.5 | 2.7s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.1 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 43.4 | 2.0s |

### OpenAI GPT

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | $1.07 | $8.50 | $0 | $0.11 | 55.2 | 4.4s |
| GPT-5 Mini | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 77.5 | 19.2s |
| GPT-5 Codex | `gpt-5-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | $1.74 | $14.00 | $0 | $0.17 | 41.1 | 2.5s |
| GPT-5.4 | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 50.4 | 21.3s |

OpenAI Cache Write is always $0. Caching is automatic on OpenAI side.

## MODELS — SPARK

Spark channel (x1 multiplier). Anthropic Claude only. `[1m]` variants = x2 price.

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 42.6 | 3.6s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $10.00 | $37.50 | $12.50 | $1.00 | 37.2 | 5.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $6.00 | $22.50 | $7.50 | $0.60 | 41.7 | 4.2s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 54.5 | 2.9s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

## CONFIG — CLAUDE CODE

File: `~/.claude/settings.json`

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_YOUR_KEY",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

Russia: replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`.
Spark: replace `/alpha` with `/spark`.

## CONFIG — CODEX CLI

Method 1 — env vars:

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha/v1"
export OPENAI_API_KEY="sk_live_YOUR_KEY"
codex
```

Method 2 — file `~/.config/codex/config.toml`:

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

```bash
export NEKOCODE_API_KEY="sk_live_YOUR_KEY"
codex --provider nekocode
```

URL must end with `/v1`.

## CONFIG — OPENCODE

File: `opencode.json` (project root or `~/.config/opencode/`)

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "sk_live_YOUR_KEY",
        "baseURL": "https://gateway.nekocode.app/alpha/v1",
        "headers": {
          "anthropic-beta": "claude-code-20250219,interleaved-thinking-2025-05-14,fine-grained-tool-streaming-2025-05-14,adaptive-thinking-2026-01-28"
        }
      }
    }
  }
}
```

baseURL must end with `/v1`.

## CONFIG — OPENCLAW

File: `~/.openclaw/openclaw.json`

Add provider:

```json
{
  "models": {
    "mode": "merge",
    "providers": {
      "nekocode": {
        "baseUrl": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_YOUR_KEY",
        "api": "anthropic-messages",
        "models": [
          {
            "id": "claude-opus-4-6",
            "name": "Claude Opus 4.6 (Nekocode Alpha)",
            "reasoning": true,
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 16384
          },
          {
            "id": "claude-sonnet-4-6",
            "name": "Claude Sonnet 4.6 (Nekocode Alpha)",
            "reasoning": true,
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 16384
          },
          {
            "id": "claude-haiku-4-5",
            "name": "Claude Haiku 4.5 (Nekocode Alpha)",
            "reasoning": false,
            "input": ["text", "image"],
            "contextWindow": 200000,
            "maxTokens": 8192
          }
        ]
      }
    }
  }
}
```

Switch model in chat: `/model neko-sonnet` or `/model neko-opus`.
baseUrl does NOT end with `/v1`.

## CONFIG — CURSOR

Anthropic models:
1. Settings (`Cmd+,`) → Models → Anthropic
2. Override Anthropic Base URL: `https://gateway.nekocode.app/alpha`
3. Anthropic API Key: `sk_live_YOUR_KEY`

OpenAI models:
1. Settings (`Cmd+,`) → Models → OpenAI
2. Override OpenAI Base URL: `https://gateway.nekocode.app/alpha/v1`
3. API Key: `sk_live_YOUR_KEY`

## CONFIG — AIDER

Method 1 — env vars:

```bash
export ANTHROPIC_API_KEY="sk_live_YOUR_KEY"
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
aider --model claude-sonnet-4-6
```

Method 2 — flags:

```bash
aider --api-base anthropic=https://gateway.nekocode.app/alpha \
      --api-key anthropic=sk_live_YOUR_KEY \
      --model claude-sonnet-4-6
```

Method 3 — `.aider.conf.yml`:

```yaml
api-base:
  anthropic: https://gateway.nekocode.app/alpha
api-key:
  anthropic: sk_live_YOUR_KEY
model: claude-sonnet-4-6
```

## CONFIG — WINDSURF

1. Settings → AI Provider
2. Custom Anthropic Base URL: `https://gateway.nekocode.app/alpha`
3. API Key: `sk_live_YOUR_KEY`
4. Select model: `claude-sonnet-4-6` or `claude-opus-4-6`

## CONFIG — CONTINUE.DEV

File: `~/.continue/config.json`

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_YOUR_KEY"
    }
  ]
}
```

## CONFIG — ANTHROPIC SDK

Python:

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_YOUR_KEY",
    base_url="https://gateway.nekocode.app/alpha"
)

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)
```

TypeScript:

```typescript
import Anthropic from '@anthropic-ai/sdk';

const client = new Anthropic({
  apiKey: 'sk_live_YOUR_KEY',
  baseURL: 'https://gateway.nekocode.app/alpha',
});

const message = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }],
});
```

OpenAI SDK (for GPT models) — add `/v1` to URL:

Python: `base_url="https://gateway.nekocode.app/alpha/v1"`
TypeScript: `baseURL: 'https://gateway.nekocode.app/alpha/v1'`

## CONFIG — CURL

Anthropic (Claude):

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{"model":"claude-sonnet-4-6","max_tokens":1024,"messages":[{"role":"user","content":"Hello!"}]}'
```

OpenAI (GPT):

```bash
curl https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_YOUR_KEY" \
  -d '{"model":"gpt-5","messages":[{"role":"user","content":"Hello!"}]}'
```

Streaming: add `"stream": true` to request body.

## REVERT

| Tool | How to revert |
|------|---------------|
| Claude Code | Remove `ANTHROPIC_AUTH_TOKEN`, `ANTHROPIC_BASE_URL`, `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` from `env` in `~/.claude/settings.json` |
| Codex CLI | `unset OPENAI_BASE_URL OPENAI_API_KEY` or remove `[model_providers.nekocode]` from `config.toml` |
| OpenCode | Remove `"provider"` block from `opencode.json`, use `/connect` to reconfigure |
| OpenClaw | Remove `nekocode` from `models.providers`, `agents.defaults.model.fallbacks`, `agents.defaults.models` |
| Cursor | Clear Override Base URL fields in Settings → Models for both Anthropic and OpenAI |
| Aider | `unset ANTHROPIC_API_KEY ANTHROPIC_API_BASE` or remove `api-base`/`api-key` from `.aider.conf.yml` |
| Windsurf | Clear Custom Anthropic Base URL field, re-enter standard Anthropic API key |
| Continue.dev | Remove Nekocode model object from `models` array or change `apiBase` to `https://api.anthropic.com` |
| Anthropic SDK | Remove `base_url`/`baseURL` parameter (defaults to `https://api.anthropic.com`) |
| OpenAI SDK | Remove `base_url`/`baseURL` parameter (defaults to `https://api.openai.com/v1`) |

## TROUBLESHOOTING

| Problem | Solution |
|---------|----------|
| 429 Too Many Requests | Wait, retry. Switch gateway or channel. Reduce concurrent requests. |
| Gateway unreachable from Russia | Use `ru.gateway.nekocode.app`, then `ru-2`, then `ru-3`. Check status.nekocode.app. |
| Connection timeout | Check status.nekocode.app. Try different gateway. Increase client timeout. Check firewall. |
| Invalid API key (401) | Key must start with `sk_live_`. Check dashboard. No extra spaces. Create new key if compromised. |
| Model not found | Use exact model ID (e.g. `claude-sonnet-4-6`, not `claude-sonnet`). IDs are case-sensitive. |
| High latency | Use Alpha channel. Choose nearest gateway. Reduce `max_tokens`. |
| CORS errors | API is server-side only. Proxy through your backend. |
| Claude Code "extra usage required" | Switch to Spark channel. Reduce context. Use `/compact`. Check balance. |
| OpenCode "provider not found" | `baseURL` must end with `/v1`. Restart OpenCode after config change. |
| Codex CLI "missing API key" | Check env var name matches provider: `OPENAI_API_KEY` for OpenAI mode, `ANTHROPIC_API_KEY` for Anthropic mode. Restart terminal. |
| 502/503 | Gateway temporarily down. Switch to alternate gateway. Check status.nekocode.app. |
