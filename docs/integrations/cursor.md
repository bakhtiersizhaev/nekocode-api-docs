# Cursor + Nekocode

> Дата обновления: 24 марта 2026

## Что такое Cursor

[Cursor](https://cursor.com) — AI-powered IDE на базе VS Code. Поддерживает кастомные API-эндпоинты для OpenAI и Anthropic моделей.

## Подключение через Nekocode

### Для моделей Anthropic (Claude)

1. Откройте Settings (`Cmd+,` / `Ctrl+,`)
2. Перейдите в раздел **Models**
3. В секции Anthropic:
   - **Override Anthropic Base URL:** `https://gateway.nekocode.app/alpha`
   - **Anthropic API Key:** `sk_live_your_api_key`
4. Выберите модель из списка доступных

### Для моделей OpenAI

1. Откройте Settings (`Cmd+,` / `Ctrl+,`)
2. Перейдите в раздел **Models**
3. В секции OpenAI:
   - **Override OpenAI Base URL:** `https://gateway.nekocode.app/alpha/v1`
   - **API Key:** `sk_live_your_api_key`
4. Выберите модель из списка доступных

### Каналы

| Канал | Anthropic URL | OpenAI URL |
|-------|---------------|------------|
| Alpha | `https://gateway.nekocode.app/alpha` | `https://gateway.nekocode.app/alpha/v1` |
| Spark | `https://gateway.nekocode.app/spark` | `https://gateway.nekocode.app/spark/v1` |

### Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app` в соответствующих URL.

## Откат к стандартным API

1. Откройте Settings
2. Очистите поля Override Base URL (и для OpenAI, и для Anthropic)
3. Введите стандартные API-ключи ваших провайдеров

---

# Cursor + Nekocode

> Updated: March 24, 2026

## What is Cursor

[Cursor](https://cursor.com) is an AI-powered IDE based on VS Code. Supports custom API endpoints for OpenAI and Anthropic models.

## Connecting via Nekocode

### For Anthropic models (Claude)

1. Open Settings (`Cmd+,` / `Ctrl+,`)
2. Go to the **Models** section
3. In the Anthropic section:
   - **Override Anthropic Base URL:** `https://gateway.nekocode.app/alpha`
   - **Anthropic API Key:** `sk_live_your_api_key`
4. Select a model from the available list

### For OpenAI models

1. Open Settings (`Cmd+,` / `Ctrl+,`)
2. Go to the **Models** section
3. In the OpenAI section:
   - **Override OpenAI Base URL:** `https://gateway.nekocode.app/alpha/v1`
   - **API Key:** `sk_live_your_api_key`
4. Select a model from the available list

### Channels

| Channel | Anthropic URL | OpenAI URL |
|---------|---------------|------------|
| Alpha | `https://gateway.nekocode.app/alpha` | `https://gateway.nekocode.app/alpha/v1` |
| Spark | `https://gateway.nekocode.app/spark` | `https://gateway.nekocode.app/spark/v1` |

### Russia gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app` in the respective URLs.

## Reverting to standard APIs

1. Open Settings
2. Clear the Override Base URL fields (both OpenAI and Anthropic)
3. Enter your standard provider API keys
