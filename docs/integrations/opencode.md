# OpenCode + Nekocode

> Дата обновления: 24 марта 2026

## Что такое OpenCode

[OpenCode](https://opencode.ai) — open-source AI-агент для кодинга в терминале.

## Подключение через Nekocode

Конфигурация задаётся в файле `opencode.json` (корень проекта или `~/.config/opencode/`).

### Настройка (Claude модели)

```json
{
  "$schema": "https://opencode.ai/config.json",
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

### Настройка (Claude + GPT + Codex — полная)

Для доступа ко всем моделям используйте два провайдера:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "nekocode": {
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "apiKey": "sk_live_your_api_key",
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      }
    },
    "nekocode-codex": {
      "npm": "@ai-sdk/openai",
      "options": {
        "apiKey": "sk_live_your_api_key",
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      },
      "models": {
        "gpt-5-codex": {
          "name": "GPT-5 Codex",
          "options": {
            "responsesApiSupported": true,
            "store": false
          }
        },
        "gpt-5.1-codex": {
          "name": "GPT-5.1 Codex",
          "options": {
            "responsesApiSupported": true,
            "store": false
          }
        },
        "gpt-5.2-codex": {
          "name": "GPT-5.2 Codex",
          "options": {
            "responsesApiSupported": true,
            "store": false
          }
        },
        "gpt-5.3-codex": {
          "name": "GPT-5.3 Codex",
          "options": {
            "responsesApiSupported": true,
            "store": false
          }
        }
      }
    }
  }
}
```

> **Зачем два провайдера?**
> - `nekocode` (`@ai-sdk/openai-compatible`) — для Claude и обычных GPT моделей (Chat Completions API)
> - `nekocode-codex` (`@ai-sdk/openai`) — для Codex моделей (Responses API `/v1/responses`)
>
> **Важно для Codex моделей:**
> - `responsesApiSupported: true` — включает Responses API вместо Chat Completions
> - `store: false` — отключает `item_reference` сообщения которые Nekocode не поддерживает
> - Без этих опций получите ошибку `Unknown parameter: 'reasoningSummary'`
>
> Codex модели (gpt-5-codex, gpt-5.1-codex и т.д.) работают **ТОЛЬКО** через Responses API.

> **Важно:** `baseURL` для OpenCode обязательно должен заканчиваться на `/v1`.

### Каналы

| Канал | URL | Особенности |
|-------|-----|-------------|
| Alpha | `https://gateway.nekocode.app/alpha/v1` | x0.3 от стоимости |
| Spark | `https://gateway.nekocode.app/spark/v1` | x1, контекст до 1M токенов |

### Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha/v1
```

## Откат к стандартному Anthropic API

Удалите весь блок `"provider"` из `opencode.json`. Затем настройте стандартный API-ключ Anthropic через команду `/connect` в интерфейсе OpenCode.

---

# OpenCode + Nekocode

> Updated: March 24, 2026

## What is OpenCode

[OpenCode](https://opencode.ai) is an open-source AI coding agent for the terminal.

## Connecting via Nekocode

Configuration is set in `opencode.json` (project root or `~/.config/opencode/`).

### Setup (Claude models only)

```json
{
  "$schema": "https://opencode.ai/config.json",
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

### Setup (Claude + GPT + Codex — full)

For access to all models, use two providers:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "nekocode": {
      "npm": "@ai-sdk/openai-compatible",
      "options": {
        "apiKey": "sk_live_your_api_key",
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      }
    },
    "nekocode-codex": {
      "npm": "@ai-sdk/openai",
      "options": {
        "apiKey": "sk_live_your_api_key",
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      },
      "models": {
        "gpt-5-codex": {
          "name": "GPT-5 Codex",
          "options": { "responsesApiSupported": true, "store": false }
        },
        "gpt-5.1-codex": {
          "name": "GPT-5.1 Codex",
          "options": { "responsesApiSupported": true, "store": false }
        },
        "gpt-5.2-codex": {
          "name": "GPT-5.2 Codex",
          "options": { "responsesApiSupported": true, "store": false }
        },
        "gpt-5.3-codex": {
          "name": "GPT-5.3 Codex",
          "options": { "responsesApiSupported": true, "store": false }
        }
      }
    }
  }
}
```

> **Why two providers?**
> - `nekocode` (`@ai-sdk/openai-compatible`) — for Claude and regular GPT models (Chat Completions API)
> - `nekocode-codex` (`@ai-sdk/openai`) — for Codex models (Responses API `/v1/responses`)
>
> **Important for Codex models:**
> - `responsesApiSupported: true` — enables Responses API instead of Chat Completions
> - `store: false` — disables `item_reference` messages that Nekocode doesn't support
> - Without these options you'll get `Unknown parameter: 'reasoningSummary'` error
>
> Codex models (gpt-5-codex, gpt-5.1-codex, etc.) work **ONLY** through the Responses API.

> **Important:** `baseURL` for OpenCode must end with `/v1`.

### Channels

| Channel | URL | Details |
|---------|-----|---------|
| Alpha | `https://gateway.nekocode.app/alpha/v1` | x0.3 price multiplier |
| Spark | `https://gateway.nekocode.app/spark/v1` | x1 price, up to 1M context |

### Russia gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha/v1
```

## Reverting to standard Anthropic API

Remove the entire `"provider"` block from `opencode.json`. Then configure a standard Anthropic API key via the `/connect` command in the OpenCode interface.
