# cURL / HTTP-запросы

> Дата обновления: 24 марта 2026

## Обзор

Примеры прямых HTTP-запросов к Nekocode через cURL. Подходит для тестирования, отладки и интеграции на любом языке программирования.

## Anthropic API (модели Claude)

### Базовый запрос

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### Стриминг (Anthropic)

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "stream": true,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

Ответ приходит в формате SSE (Server-Sent Events). Каждая строка начинается с `data: `.

## OpenAI API (модели GPT — обычные)

> Для обычных GPT моделей (gpt-5, gpt-5-mini, gpt-5.1, gpt-5.2, gpt-5.4) используйте `/v1/chat/completions`.

### Базовый запрос

```bash
curl https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## OpenAI Responses API (модели Codex)

> **ВАЖНО:** Codex модели (gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex) работают **ТОЛЬКО** через `/v1/responses`. Через `/v1/chat/completions` вернётся `model_not_found`.

```bash
curl https://gateway.nekocode.app/alpha/v1/responses \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5.3-codex",
    "max_output_tokens": 4096,
    "input": "Write a Python function to sort a list of dictionaries by key"
  }'
```

> `max_output_tokens` для Codex должен быть **>= 16**, иначе ошибка.

### Стриминг (OpenAI)

```bash
curl https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "stream": true,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app`:

```bash
# Anthropic (Claude)
curl https://ru.gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Привет!"}]
  }'

# OpenAI (GPT)
curl https://ru.gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role": "user", "content": "Привет!"}]
  }'
```

## Проверка соединения

Быстрый тест, что ваш ключ работает и шлюз доступен:

```bash
curl -s -o /dev/null -w "%{http_code}" \
  https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 10,
    "messages": [{"role": "user", "content": "ping"}]
  }'
```

- `200` — всё работает
- `401` — неверный API-ключ
- `403` — ключ заблокирован или нет доступа к модели
- `429` — превышен лимит запросов
- `502` / `503` — шлюз временно недоступен

## Доступные каналы

| Канал | Base URL                                       |
|-------|------------------------------------------------|
| alpha | `https://gateway.nekocode.app/alpha/v1`        |
| spark | `https://gateway.nekocode.app/spark/v1`        |

## Заголовки аутентификации

| API       | Заголовок                               |
|-----------|-----------------------------------------|
| Anthropic | `x-api-key: sk_live_your_api_key`       |
| OpenAI    | `Authorization: Bearer sk_live_your_api_key` |

---

# cURL / HTTP Requests

> Updated: March 24, 2026

## Overview

Examples of direct HTTP requests to Nekocode via cURL. Suitable for testing, debugging, and integration in any programming language.

## Anthropic API (Claude Models)

### Basic Request

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### Streaming (Anthropic)

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "stream": true,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

Response is delivered as SSE (Server-Sent Events). Each line starts with `data: `.

## OpenAI API (GPT Models)

### Basic Request

```bash
curl https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### Streaming (OpenAI)

```bash
curl https://gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "stream": true,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## Russia Gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`:

```bash
# Anthropic (Claude)
curl https://ru.gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'

# OpenAI (GPT)
curl https://ru.gateway.nekocode.app/alpha/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer sk_live_your_api_key" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

## Test Connection

Quick test to verify your key works and the gateway is reachable:

```bash
curl -s -o /dev/null -w "%{http_code}" \
  https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_your_api_key" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 10,
    "messages": [{"role": "user", "content": "ping"}]
  }'
```

- `200` — everything works
- `401` — invalid API key
- `403` — key blocked or no access to model
- `429` — rate limit exceeded
- `502` / `503` — gateway temporarily unavailable

## Available Channels

| Channel | Base URL                                       |
|---------|------------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha/v1`        |
| spark   | `https://gateway.nekocode.app/spark/v1`        |

## Authentication Headers

| API       | Header                                        |
|-----------|-----------------------------------------------|
| Anthropic | `x-api-key: sk_live_your_api_key`             |
| OpenAI    | `Authorization: Bearer sk_live_your_api_key`  |
