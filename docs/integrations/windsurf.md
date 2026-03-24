# Интеграция с Windsurf IDE

> Дата обновления: 24 марта 2026

## О Windsurf

[Windsurf](https://windsurf.com) — AI-powered IDE от Codeium. Поддерживает подключение кастомных AI-провайдеров через настройки.

## Настройка

1. Откройте **Settings > AI Provider**
2. В поле **Custom Anthropic Base URL** укажите:
   ```
   https://gateway.nekocode.app/alpha
   ```
3. В поле **API Key** введите ваш ключ:
   ```
   sk_live_your_api_key
   ```
4. Выберите модель: `claude-sonnet-4-6` или `claude-opus-4-6`

## Шлюз для России

Замените Base URL на:

```
https://ru.gateway.nekocode.app/alpha
```

Все остальные настройки остаются прежними.

## Доступные каналы

| Канал   | URL                                          |
|---------|----------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha`         |
| spark   | `https://gateway.nekocode.app/spark`         |

Для SDK-совместимого доступа добавьте `/v1`:

```
https://gateway.nekocode.app/alpha/v1
```

## Откат к стандартным настройкам

Чтобы вернуться к стандартному Anthropic API:

1. Очистите поле **Custom Anthropic Base URL** (оставьте пустым)
2. Удалите текущий API-ключ Nekocode
3. Введите ваш стандартный API-ключ Anthropic

После этого Windsurf будет обращаться напрямую к `api.anthropic.com`.

---

# Windsurf IDE Integration

> Updated: March 24, 2026

## About Windsurf

[Windsurf](https://windsurf.com) — AI-powered IDE by Codeium. Supports connecting custom AI providers through settings.

## Setup

1. Open **Settings > AI Provider**
2. Set **Custom Anthropic Base URL** to:
   ```
   https://gateway.nekocode.app/alpha
   ```
3. Set **API Key** to your Nekocode key:
   ```
   sk_live_your_api_key
   ```
4. Select model: `claude-sonnet-4-6` or `claude-opus-4-6`

## Russia Gateway

Change the Base URL to:

```
https://ru.gateway.nekocode.app/alpha
```

All other settings remain the same.

## Available Channels

| Channel | URL                                          |
|---------|----------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha`         |
| spark   | `https://gateway.nekocode.app/spark`         |

For SDK-compatible access, append `/v1`:

```
https://gateway.nekocode.app/alpha/v1
```

## Reverting to Default Settings

To revert to the standard Anthropic API:

1. Clear the **Custom Anthropic Base URL** field (leave empty)
2. Remove your current Nekocode API key
3. Re-enter your standard Anthropic API key

Windsurf will then connect directly to `api.anthropic.com`.
