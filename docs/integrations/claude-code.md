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

> **Все три переменные ОБЯЗАТЕЛЬНЫ:**
> - `ANTHROPIC_AUTH_TOKEN` — ваш Nekocode API ключ
> - `ANTHROPIC_BASE_URL` — URL шлюза (без `/v1` — Claude Code добавит сам)
> - `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` — **обязательно "1"**, иначе Claude Code отправляет дополнительные параметры (`context_management` и др.) которые Nekocode не поддерживает, и вы получите ошибку `400 Extra inputs are not permitted`
>
> Проверено: Claude Code + Nekocode Alpha — работает. Тест 24 марта 2026.

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

> **All three variables are REQUIRED:**
> - `ANTHROPIC_AUTH_TOKEN` — your Nekocode API key
> - `ANTHROPIC_BASE_URL` — gateway URL (without `/v1` — Claude Code adds it automatically)
> - `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC` — **must be "1"**, otherwise Claude Code sends additional parameters (`context_management`, etc.) that Nekocode doesn't support, resulting in `400 Extra inputs are not permitted` error
>
> Verified: Claude Code + Nekocode Alpha — works. Tested March 24, 2026.

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
