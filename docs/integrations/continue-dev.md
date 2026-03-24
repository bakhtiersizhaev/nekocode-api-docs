# Интеграция с Continue.dev

> Дата обновления: 24 марта 2026

## О Continue.dev

[Continue.dev](https://continue.dev) — open-source расширение для AI-автодополнения и чата в VSCode и JetBrains. Позволяет подключать любые LLM-провайдеры через файл конфигурации.

## Настройка

Отредактируйте файл `~/.continue/config.json` и добавьте модель Nekocode в массив `models`:

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    }
  ]
}
```

### Несколько моделей

Вы можете добавить несколько моделей и переключаться между ними в интерфейсе Continue:

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    },
    {
      "title": "Claude Opus 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-opus-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    }
  ]
}
```

## Шлюз для России

Замените `apiBase` на:

```
https://ru.gateway.nekocode.app/alpha
```

## Доступные каналы

| Канал   | apiBase                                      |
|---------|----------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha`         |
| spark   | `https://gateway.nekocode.app/spark`         |

## Откат к стандартным настройкам

Чтобы вернуться к стандартному Anthropic API:

- Удалите объект модели Nekocode из массива `models`, или
- Замените `apiBase` на стандартный URL Anthropic: `https://api.anthropic.com`
- Укажите ваш стандартный API-ключ Anthropic в поле `apiKey`

---

# Continue.dev Integration

> Updated: March 24, 2026

## About Continue.dev

[Continue.dev](https://continue.dev) — open-source AI autocomplete and chat extension for VSCode and JetBrains. Supports connecting any LLM provider via configuration file.

## Setup

Edit `~/.continue/config.json` and add a Nekocode model to the `models` array:

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    }
  ]
}
```

### Multiple Models

You can add multiple models and switch between them in the Continue interface:

```json
{
  "models": [
    {
      "title": "Claude Sonnet 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    },
    {
      "title": "Claude Opus 4.6 (Nekocode)",
      "provider": "anthropic",
      "model": "claude-opus-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_your_api_key"
    }
  ]
}
```

## Russia Gateway

Change `apiBase` to:

```
https://ru.gateway.nekocode.app/alpha
```

## Available Channels

| Channel | apiBase                                      |
|---------|----------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha`         |
| spark   | `https://gateway.nekocode.app/spark`         |

## Reverting to Default Settings

To revert to the standard Anthropic API:

- Remove the Nekocode model object from the `models` array, or
- Change `apiBase` back to the default Anthropic URL: `https://api.anthropic.com`
- Set your standard Anthropic API key in the `apiKey` field
