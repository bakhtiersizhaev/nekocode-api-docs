# Claude Code + Nekocode

> Дата обновления: 24 марта 2026

## Что такое Claude Code

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) — CLI-инструмент от Anthropic для работы с кодом через терминал. Поддерживает все модели Claude.

## Подключение через Nekocode

Конфигурация задаётся в файле `~/.claude/settings.json`.

### Настройка

Добавьте (или замените) блок `env`:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_your_api_key",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

### Каналы

| Канал | URL | Особенности |
|-------|-----|-------------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 от стоимости |
| Spark | `https://gateway.nekocode.app/spark` | x1, контекст до 1M токенов |

Для канала Spark замените `/alpha` на `/spark` в URL.

### Шлюз для России

Замените базовый URL на:

```
https://ru.gateway.nekocode.app/alpha
```

### Выбор модели

Claude Code автоматически использует модель, доступную по подписке. Через Nekocode вы получаете доступ ко всем моделям Claude без ограничений подписки.

## Откат к стандартной подписке Anthropic

Удалите три переменные окружения из `env` в `settings.json`, либо установите их значения в пустую строку:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "",
    "ANTHROPIC_BASE_URL": "",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": ""
  }
}
```

---

# Claude Code + Nekocode

> Updated: March 24, 2026

## What is Claude Code

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) is a CLI tool by Anthropic for working with code via the terminal. Supports all Claude models.

## Connecting via Nekocode

Configuration is set in `~/.claude/settings.json`.

### Setup

Add (or replace) the `env` block:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_your_api_key",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

### Channels

| Channel | URL | Details |
|---------|-----|---------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 price multiplier |
| Spark | `https://gateway.nekocode.app/spark` | x1 price, up to 1M context |

For the Spark channel, replace `/alpha` with `/spark` in the URL.

### Russia gateway

Replace the base URL with:

```
https://ru.gateway.nekocode.app/alpha
```

### Model selection

Claude Code automatically uses the model available under your subscription. Through Nekocode you get access to all Claude models without subscription restrictions.

## Reverting to standard Anthropic subscription

Remove the three environment variables from `env` in `settings.json`, or set their values to empty strings:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "",
    "ANTHROPIC_BASE_URL": "",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": ""
  }
}
```
