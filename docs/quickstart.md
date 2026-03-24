# Быстрый старт

> Последнее обновление: 24 марта 2026

Nekocode — единый AI-шлюз, который предоставляет доступ к моделям Anthropic Claude и OpenAI GPT через один API-ключ. Ниже — пошаговая инструкция от регистрации до первого запроса.

## 1. Регистрация

Перейди на [nekocode.app](https://nekocode.app) и создай аккаунт. Доступна авторизация через Telegram.

## 2. Получи API-ключ

Открой [Dashboard → API Keys](https://nekocode.app/dashboard/api-keys) и создай новый ключ. Формат ключа:

```
sk_live_your_api_key_here
```

> **Важно:** ключ показывается только один раз. Сохрани его в безопасном месте. Если потерял — отзови старый и создай новый.

## 3. Выбери канал

| Канал | Множитель цены | Контекст | Для чего |
|-------|---------------|----------|----------|
| **Alpha** | x0.3 | 200K токенов | Ежедневная работа, экономия бюджета |
| **Spark** | x1 | 1M токенов | Большие контексты, сложные задачи |

Подробнее: [channels.md](channels.md)

## 4. Выбери gateway

| Gateway | URL | Для кого |
|---------|-----|----------|
| Default | `gateway.nekocode.app` | Глобальный доступ (EU/US) |
| Russia | `ru.gateway.nekocode.app` | Пользователи из РФ/СНГ |
| Russia #2 | `ru-2.gateway.nekocode.app` | Резервный РФ |
| Russia #3 | `ru-3.gateway.nekocode.app` | Резервный РФ |

Если ты в России — используй `ru.gateway.nekocode.app`. Если не работает — переключись на `ru-2` или `ru-3`. Подробнее: [gateways.md](gateways.md)

## 5. Настрой свой инструмент

Nekocode работает с любым инструментом, поддерживающим Anthropic или OpenAI API. Полные инструкции по настройке:

- [Claude Code](switching.md#claude-code)
- [Codex CLI](switching.md#codex-cli)
- [OpenCode](switching.md#opencode)
- [OpenClaw](switching.md#openclaw)
- [Cursor](switching.md#cursor)
- [Aider](switching.md#aider)
- [Windsurf](switching.md#windsurf)
- [Continue.dev](switching.md#continuedev)
- [Anthropic SDK](switching.md#anthropic-sdk)
- [Terminal / curl](switching.md#terminal--curl)

Подробнее: [switching.md](switching.md)

## 6. Проверь подключение

Выполни тестовый запрос через curl, подставив свой ключ и выбранный gateway/канал:

### Alpha канал (x0.3 цена)

```bash
curl https://ru.gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY_HERE" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 256,
    "messages": [
      {"role": "user", "content": "Привет! Скажи одно предложение."}
    ]
  }'
```

### Spark канал (1M контекст)

```bash
curl https://ru.gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY_HERE" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 256,
    "messages": [
      {"role": "user", "content": "Hello! Say one sentence."}
    ]
  }'
```

Если получил ответ с `"content"` — всё работает. Если ошибка — см. [troubleshooting.md](troubleshooting.md).

## Что дальше

- [Каналы и тарификация](channels.md)
- [Гейтвеи и регионы](gateways.md)
- [Переключение инструментов](switching.md)
- [Мониторинг статуса](status.md)
- [Решение проблем](troubleshooting.md)

---

# Quick Start

> Last updated: March 24, 2026

Nekocode is a unified AI gateway that provides access to Anthropic Claude and OpenAI GPT models through a single API key. Below is a step-by-step guide from registration to your first request.

## 1. Sign Up

Go to [nekocode.app](https://nekocode.app) and create an account. Telegram authorization is available.

## 2. Get Your API Key

Open [Dashboard → API Keys](https://nekocode.app/dashboard/api-keys) and create a new key. Key format:

```
sk_live_your_api_key_here
```

> **Important:** the key is shown only once. Save it in a secure location. If lost — revoke the old one and create a new key.

## 3. Choose a Channel

| Channel | Price multiplier | Context | Use case |
|---------|-----------------|---------|----------|
| **Alpha** | x0.3 | 200K tokens | Daily work, budget-friendly |
| **Spark** | x1 | 1M tokens | Large contexts, complex tasks |

Details: [channels.md](channels.md)

## 4. Choose a Gateway

| Gateway | URL | For whom |
|---------|-----|----------|
| Default | `gateway.nekocode.app` | Global access (EU/US) |
| Russia | `ru.gateway.nekocode.app` | Users in Russia/CIS |
| Russia #2 | `ru-2.gateway.nekocode.app` | Backup (Russia) |
| Russia #3 | `ru-3.gateway.nekocode.app` | Backup (Russia) |

If you're in Russia — use `ru.gateway.nekocode.app`. If it's down — switch to `ru-2` or `ru-3`. Details: [gateways.md](gateways.md)

## 5. Configure Your Tool

Nekocode works with any tool that supports the Anthropic or OpenAI API. Full setup instructions:

- [Claude Code](switching.md#claude-code)
- [Codex CLI](switching.md#codex-cli)
- [OpenCode](switching.md#opencode)
- [OpenClaw](switching.md#openclaw)
- [Cursor](switching.md#cursor)
- [Aider](switching.md#aider)
- [Windsurf](switching.md#windsurf)
- [Continue.dev](switching.md#continuedev)
- [Anthropic SDK](switching.md#anthropic-sdk)
- [Terminal / curl](switching.md#terminal--curl)

Details: [switching.md](switching.md)

## 6. Verify Connection

Run a test request via curl, substituting your key and chosen gateway/channel:

### Alpha channel (x0.3 price)

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY_HERE" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 256,
    "messages": [
      {"role": "user", "content": "Hello! Say one sentence."}
    ]
  }'
```

### Spark channel (1M context)

```bash
curl https://gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY_HERE" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 256,
    "messages": [
      {"role": "user", "content": "Hello! Say one sentence."}
    ]
  }'
```

If you received a response with `"content"` — everything works. If there's an error — see [troubleshooting.md](troubleshooting.md).

## What's Next

- [Channels and pricing](channels.md)
- [Gateways and regions](gateways.md)
- [Switching tools](switching.md)
- [Status monitoring](status.md)
- [Troubleshooting](troubleshooting.md)
