# OpenClaw + Nekocode

> Дата обновления: 24 марта 2026

## Что такое OpenClaw

[OpenClaw](https://openclaw.ai) — персональный AI-ассистент от @steipete. Поддерживает кастомных провайдеров через конфигурацию.

## Подключение через Nekocode

Конфигурация задаётся в файле `~/.openclaw/openclaw.json`.

### Шаг 1 — Добавить провайдер Nekocode

Добавьте `nekocode` в секцию `models.providers`:

```json
{
  "models": {
    "mode": "merge",
    "providers": {
      "nekocode": {
        "baseUrl": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_your_api_key",
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
          }
        ]
      }
    }
  }
}
```

### Шаг 2 — Настроить модели и фоллбэки

Добавьте модели Nekocode в allowlist агентов и настройте фоллбэки:

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-sonnet-4-6",
        "fallbacks": [
          "nekocode/claude-sonnet-4-6",
          "nekocode/claude-opus-4-6",
          "anthropic/claude-opus-4-6"
        ]
      },
      "models": {
        "nekocode/claude-sonnet-4-6": { "alias": "neko-sonnet" },
        "nekocode/claude-opus-4-6": { "alias": "neko-opus" }
      }
    }
  }
}
```

### Переключение модели в чате

```
/model neko-sonnet
/model neko-opus
```

### Каналы

| Канал | URL | Особенности |
|-------|-----|-------------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 от стоимости |
| Spark | `https://gateway.nekocode.app/spark` | x1, контекст до 1M токенов |

### Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha
```

## Откат

Удалите `nekocode` из:
1. `models.providers` — убрать весь блок провайдера
2. `agents.defaults.model.fallbacks` — убрать `nekocode/*` записи
3. `agents.defaults.models` — убрать `nekocode/*` алиасы

---

# OpenClaw + Nekocode

> Updated: March 24, 2026

## What is OpenClaw

[OpenClaw](https://openclaw.ai) is a personal AI assistant by @steipete. Supports custom providers via configuration.

## Connecting via Nekocode

Configuration is set in `~/.openclaw/openclaw.json`.

### Step 1 — Add Nekocode provider

Add `nekocode` to the `models.providers` section:

```json
{
  "models": {
    "mode": "merge",
    "providers": {
      "nekocode": {
        "baseUrl": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_your_api_key",
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
          }
        ]
      }
    }
  }
}
```

### Step 2 — Configure models and fallbacks

Add Nekocode models to the agents allowlist and configure fallbacks:

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-sonnet-4-6",
        "fallbacks": [
          "nekocode/claude-sonnet-4-6",
          "nekocode/claude-opus-4-6",
          "anthropic/claude-opus-4-6"
        ]
      },
      "models": {
        "nekocode/claude-sonnet-4-6": { "alias": "neko-sonnet" },
        "nekocode/claude-opus-4-6": { "alias": "neko-opus" }
      }
    }
  }
}
```

### Switching models in chat

```
/model neko-sonnet
/model neko-opus
```

### Channels

| Channel | URL | Details |
|---------|-----|---------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 price multiplier |
| Spark | `https://gateway.nekocode.app/spark` | x1 price, up to 1M context |

### Russia gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha
```

## Reverting

Remove `nekocode` from:
1. `models.providers` — remove the entire provider block
2. `agents.defaults.model.fallbacks` — remove `nekocode/*` entries
3. `agents.defaults.models` — remove `nekocode/*` aliases
