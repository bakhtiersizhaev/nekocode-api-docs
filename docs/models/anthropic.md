# Модели Anthropic Claude

> Последнее обновление: 24 марта 2026

Все модели семейства Anthropic Claude, доступные через Nekocode API. Модели представлены в двух каналах: **Alpha** (множитель x0.3, самый экономичный) и **Spark** (множитель x1, полная поддержка контекста 1M токенов).

## Обзор моделей

- **Claude Opus** — самая мощная модель семейства. Максимальное качество рассуждений, сложный анализ, генерация кода уровня senior-разработчика. Подходит для задач, где качество важнее скорости.
- **Claude Sonnet** — сбалансированная модель. Оптимальное соотношение качества, скорости и стоимости. Рекомендуется как модель по умолчанию для большинства задач.
- **Claude Haiku** — самая быстрая и дешёвая модель. Идеальна для классификации, извлечения данных, простых чат-ботов и задач с высоким объёмом запросов.

Суффикс **[1m]** в идентификаторе модели означает режим с контекстным окном в 1 миллион токенов. Без суффикса используется стандартное контекстное окно (200K токенов).

## Канал Alpha (x0.3)

Самый экономичный канал. Все цены указаны в USD за 1M токенов.

| Модель | Полный ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|-----------|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.9 | 5.1s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 39.7 | 4.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 20.7 | 3.5s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 23.1 | 8.5s |
| Claude Haiku 4.5 | `claude-haiku-4-5-20251001` | $1.00 | $5.00 | $1.25 | $0.10 | 60.7 | 2.9s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5-20250929` | $3.00 | $15.00 | $3.75 | $0.30 | 47.0 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5-20251101` | $5.00 | $25.00 | $6.25 | $0.50 | 48.6 | 3.4s |

### Алиасы (Alpha)

| Алиас | Указывает на |
|-------|-------------|
| `claude-haiku-4-5` | `claude-haiku-4-5-20251001` |
| `claude-sonnet-4-5` | `claude-sonnet-4-5-20250929` |
| `claude-opus-4-5` | `claude-opus-4-5-20251101` |

## Канал Spark (x1)

Канал с полной поддержкой контекста 1M токенов. Модели с суффиксом `[1m]` имеют удвоенную стоимость. Все цены указаны в USD за 1M токенов.

| Модель | Полный ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|-----------|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $10.00 | $37.50 | $12.50 | $1.00 | 37.2 | 5.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $6.00 | $22.50 | $7.50 | $0.60 | 39.6 | 4.7s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Примечание:** Прочерк (—) в колонках tok/s и Latency означает, что бенчмарк для данной модели в этом канале пока не проведён.

## Рекомендации по выбору

| Задача | Рекомендуемая модель | Канал |
|--------|---------------------|-------|
| Сложный анализ, исследования | Claude Opus 4.6 | Alpha |
| Кодинг, рефакторинг | Claude Opus 4.6 или Sonnet 4.6 | Alpha |
| Чат-боты, саммаризация | Claude Sonnet 4.5 / 4.6 | Alpha |
| Классификация, извлечение данных | Claude Haiku 4.5 | Alpha |
| Анализ больших документов (>200K токенов) | Claude Opus 4.6 [1M] | Spark |
| Работа с длинным контекстом при экономии | Claude Sonnet 4.6 [1M] | Spark |

---

# Anthropic Claude Models

> Last updated: March 24, 2026

All Anthropic Claude family models available through Nekocode API. Models are offered in two channels: **Alpha** (x0.3 multiplier, most cost-effective) and **Spark** (x1 multiplier, full 1M token context support).

## Model Overview

- **Claude Opus** — the most capable model in the family. Maximum reasoning quality, complex analysis, senior-level code generation. Best for tasks where quality matters more than speed.
- **Claude Sonnet** — balanced model. Optimal quality-to-speed-to-cost ratio. Recommended as the default model for most tasks.
- **Claude Haiku** — the fastest and cheapest model. Ideal for classification, data extraction, simple chatbots, and high-volume workloads.

The **[1m]** suffix in a model identifier indicates the 1 million token context window mode. Without the suffix, the standard context window (200K tokens) is used.

## Alpha Channel (x0.3)

The most cost-effective channel. All prices in USD per 1M tokens.

| Model | Full ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|---------|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.9 | 5.1s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 39.7 | 4.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 20.7 | 3.5s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 23.1 | 8.5s |
| Claude Haiku 4.5 | `claude-haiku-4-5-20251001` | $1.00 | $5.00 | $1.25 | $0.10 | 60.7 | 2.9s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5-20250929` | $3.00 | $15.00 | $3.75 | $0.30 | 47.0 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5-20251101` | $5.00 | $25.00 | $6.25 | $0.50 | 48.6 | 3.4s |

### Aliases (Alpha)

| Alias | Points to |
|-------|-----------|
| `claude-haiku-4-5` | `claude-haiku-4-5-20251001` |
| `claude-sonnet-4-5` | `claude-sonnet-4-5-20250929` |
| `claude-opus-4-5` | `claude-opus-4-5-20251101` |

## Spark Channel (x1)

Channel with full 1M token context support. Models with the `[1m]` suffix have doubled pricing. All prices in USD per 1M tokens.

| Model | Full ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|---------|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $10.00 | $37.50 | $12.50 | $1.00 | 37.2 | 5.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $6.00 | $22.50 | $7.50 | $0.60 | 39.6 | 4.7s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Note:** A dash (—) in the tok/s and Latency columns means the benchmark for that model on this channel has not been run yet.

## Selection Guide

| Task | Recommended Model | Channel |
|------|-------------------|---------|
| Complex analysis, research | Claude Opus 4.6 | Alpha |
| Coding, refactoring | Claude Opus 4.6 or Sonnet 4.6 | Alpha |
| Chatbots, summarization | Claude Sonnet 4.5 / 4.6 | Alpha |
| Classification, data extraction | Claude Haiku 4.5 | Alpha |
| Large document analysis (>200K tokens) | Claude Opus 4.6 [1M] | Spark |
| Long context on a budget | Claude Sonnet 4.6 [1M] | Spark |
