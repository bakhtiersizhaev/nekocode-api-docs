# Прайсинг: Канал Alpha (x0.3)

> Последнее обновление: 24 марта 2026

**Alpha** — самый экономичный канал Nekocode API с множителем **x0.3** от стоимости провайдера. Включает все модели Anthropic Claude и OpenAI GPT. Это оптимальный выбор для большинства задач, когда не требуется контекстное окно свыше 200K токенов.

## Почему Alpha

- **Самые низкие цены** — множитель x0.3 обеспечивает минимальную стоимость на рынке
- **Все провайдеры** — доступны и Anthropic, и OpenAI в одном канале
- **Стандартный контекст** — до 200K токенов (достаточно для 99% задач)
- **Простые алиасы** — используйте короткие идентификаторы без запоминания дат

## Полная таблица цен

Все цены указаны в USD за 1M токенов.

### Модели Anthropic Claude

| Модель | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.8 | 4.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 38.3 | 5.2s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 24.1 | 3.8s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 9.6 | 9.3s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 74.5 | 2.7s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.1 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 43.4 | 2.0s |

### Модели OpenAI GPT

| Модель | ID | Алиас | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|----|-------|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | — | $1.07 | $8.50 | $0 | $0.11 | 55.2 | 4.4s |
| GPT-5 Mini | `gpt-5-mini-2025-08-07` | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 77.5 | 19.2s |
| GPT-5 Codex | `gpt-5-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1-2025-11-13` | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2-2025-12-11` | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | — | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | — | $1.74 | $14.00 | $0 | $0.17 | 41.1 | 2.5s |
| GPT-5.4 | `gpt-5.4-2026-03-05` | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 50.4 | 21.3s |

## Сравнение по стоимости

### Самые дешёвые модели (по Input)

| # | Модель | Input / 1M | Output / 1M |
|---|--------|------------|-------------|
| 1 | GPT-5 Mini | $0.25 | $2.00 |
| 2 | Claude Haiku 4.5 | $1.00 | $5.00 |
| 3 | GPT-5 | $1.07 | $8.50 |

### Самые дорогие модели (по Input)

| # | Модель | Input / 1M | Output / 1M |
|---|--------|------------|-------------|
| 1 | Claude Opus 4.6 | $5.00 | $25.00 |
| 2 | Claude Opus 4.5 | $5.00 | $25.00 |
| 3 | GPT-5.4 | $2.50 | $15.00 |

## Особенности кэширования

- **Anthropic**: платные Cache Write и Cache Read. Кэширование промптов экономит деньги при повторных запросах с одинаковым системным промптом.
- **OpenAI**: Cache Write всегда $0. Оплачивается только Cache Read. Кэширование включается автоматически на стороне OpenAI.

## Когда использовать Alpha

- Стандартные задачи с контекстом до 200K токенов
- Нужен доступ к моделям обоих провайдеров
- Приоритет — минимизация расходов
- Прототипирование и разработка

> Если вам нужен контекст 1M токенов, рассмотрите [канал Spark](./spark.md) (только модели Anthropic).

---

# Pricing: Alpha Channel (x0.3)

> Last updated: March 24, 2026

**Alpha** is the most cost-effective Nekocode API channel with an **x0.3** multiplier against provider pricing. Includes all Anthropic Claude and OpenAI GPT models. This is the optimal choice for most tasks when you don't need a context window exceeding 200K tokens.

## Why Alpha

- **Lowest prices** — x0.3 multiplier delivers the minimum cost on the market
- **All providers** — both Anthropic and OpenAI in a single channel
- **Standard context** — up to 200K tokens (sufficient for 99% of tasks)
- **Simple aliases** — use short identifiers without memorizing dates

## Full Pricing Table

All prices in USD per 1M tokens.

### Anthropic Claude Models

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.8 | 4.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 38.3 | 5.2s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 24.1 | 3.8s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 9.6 | 9.3s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 74.5 | 2.7s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.1 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 43.4 | 2.0s |

### OpenAI GPT Models

| Model | ID | Alias | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | — | $1.07 | $8.50 | $0 | $0.11 | 55.2 | 4.4s |
| GPT-5 Mini | `gpt-5-mini-2025-08-07` | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 77.5 | 19.2s |
| GPT-5 Codex | `gpt-5-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1-2025-11-13` | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2-2025-12-11` | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | — | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | — | $1.74 | $14.00 | $0 | $0.17 | 41.1 | 2.5s |
| GPT-5.4 | `gpt-5.4-2026-03-05` | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 50.4 | 21.3s |

## Cost Comparison

### Cheapest Models (by Input)

| # | Model | Input / 1M | Output / 1M |
|---|-------|------------|-------------|
| 1 | GPT-5 Mini | $0.25 | $2.00 |
| 2 | Claude Haiku 4.5 | $1.00 | $5.00 |
| 3 | GPT-5 | $1.07 | $8.50 |

### Most Expensive Models (by Input)

| # | Model | Input / 1M | Output / 1M |
|---|-------|------------|-------------|
| 1 | Claude Opus 4.6 | $5.00 | $25.00 |
| 2 | Claude Opus 4.5 | $5.00 | $25.00 |
| 3 | GPT-5.4 | $2.50 | $15.00 |

## Caching Specifics

- **Anthropic**: Paid Cache Write and Cache Read. Prompt caching saves money on repeated requests with the same system prompt.
- **OpenAI**: Cache Write is always $0. Only Cache Read is billed. Caching is enabled automatically on OpenAI's side.

## When to Use Alpha

- Standard tasks with context up to 200K tokens
- Need access to models from both providers
- Priority is cost minimization
- Prototyping and development

> If you need 1M token context, consider the [Spark channel](./spark.md) (Anthropic models only).
