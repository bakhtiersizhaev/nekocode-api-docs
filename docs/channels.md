# Каналы

> Последнее обновление: 24 марта 2026

Каналы определяют тарификацию и лимиты контекстного окна. Канал выбирается как часть URL-пути при обращении к API.

## Формат URL

```
https://{gateway}/{channel}/v1/messages
```

Пример:

```
https://ru.gateway.nekocode.app/alpha/v1/messages
```

## Alpha

| Параметр | Значение |
|----------|----------|
| Суффикс URL | `/alpha` |
| Множитель цены | **x0.3** (70% скидка) |
| Контекстное окно | 200K токенов |
| Модели | Все Anthropic + все OpenAI + все Codex |
| API | Anthropic Messages, OpenAI Chat Completions, OpenAI Responses |
| Назначение | Ежедневная работа, разработка, код-ревью |

Alpha — основной канал для повседневного использования. Цена составляет 30% от стандартной стоимости API, что делает его идеальным для:

- Написания и рефакторинга кода
- Ежедневного взаимодействия с AI-ассистентами (Claude Code, Cursor, Aider)
- Задач, не требующих сверхбольшого контекста
- Прототипирования и экспериментов

### Модели Alpha — Anthropic Claude

Эндпоинт: `POST /alpha/v1/messages` (Anthropic Messages API)

| Model ID | Алиас | Input $/1M | Output $/1M | Cache Write | Cache Read | tok/s | Latency |
|----------|-------|-----------|------------|-------------|------------|-------|---------|
| `claude-opus-4-6` | — | $5.00 | $25.00 | $6.25 | $0.50 | 37.9 | 5.1s |
| `claude-opus-4-6[1m]` | — | $5.00 | $25.00 | $6.25 | $0.50 | 39.7 | 4.8s |
| `claude-sonnet-4-6` | — | $3.00 | $15.00 | $3.75 | $0.30 | 20.7 | 3.5s |
| `claude-sonnet-4-6[1m]` | — | $3.00 | $15.00 | $3.75 | $0.30 | 23.1 | 8.5s |
| `claude-haiku-4-5-20251001` | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 60.7 | 2.9s |
| `claude-sonnet-4-5-20250929` | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.0 | 2.4s |
| `claude-opus-4-5-20251101` | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 48.6 | 3.4s |

### Модели Alpha — OpenAI GPT (Chat Completions API)

Эндпоинт: `POST /alpha/v1/chat/completions` (обычные GPT)

| Model ID | Алиас | Input $/1M | Output $/1M | Cache Write | Cache Read | tok/s | Latency |
|----------|-------|-----------|------------|-------------|------------|-------|---------|
| `gpt-5` | — | $1.07 | $8.50 | $0 | $0.11 | — | — |
| `gpt-5-mini-2025-08-07` | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 74.0 | 16.7s |
| `gpt-5.1-2025-11-13` | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| `gpt-5.2-2025-12-11` | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| `gpt-5.4-2026-03-05` | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 24.1 | 28.7s |

### Модели Alpha — OpenAI Codex (Responses API)

Эндпоинт: `POST /alpha/v1/responses` (**ТОЛЬКО** Responses API, НЕ Chat Completions!)

| Model ID | Input $/1M | Output $/1M | Cache Write | Cache Read | tok/s | Latency |
|----------|-----------|------------|-------------|------------|-------|---------|
| `gpt-5-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| `gpt-5.1-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| `gpt-5.2-codex` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| `gpt-5.3-codex` | $1.74 | $14.00 | $0 | $0.17 | 37.5 | 2.3s |

> `max_output_tokens` для Codex моделей должен быть >= 16.

### Пример использования

```bash
curl https://ru.gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [
      {"role": "user", "content": "Напиши функцию сортировки на Python"}
    ]
  }'
```

## Spark

| Параметр | Значение |
|----------|----------|
| Суффикс URL | `/spark` |
| Множитель цены | **x1** (стандартная цена) |
| Контекстное окно | **1M токенов** (для моделей Claude) |
| Модели | **Только Anthropic Claude** |
| API | Anthropic Messages API только |
| Назначение | Большие кодовые базы, длинные документы, сложный анализ |

> **ВАЖНО:** Spark поддерживает **только модели Anthropic Claude**. Модели OpenAI GPT и Codex на Spark **НЕ работают** (вернётся ошибка 400/500). Для GPT/Codex используйте Alpha.

Spark предоставляет полный доступ к расширенному контекстному окну в 1 миллион токенов для моделей Claude. Это критически важно для:

- Работы с большими кодовыми базами (Claude Code на крупных проектах)
- Анализа длинных документов и отчётов
- Сложных задач, требующих обширного контекста
- Случаев, когда Alpha выдаёт ошибку "context too large"

### Полный список моделей Spark

Эндпоинт: `POST /spark/v1/messages` (Anthropic Messages API только)

| Model ID | Алиас | Input $/1M | Output $/1M | Cache Write | Cache Read | tok/s | Latency |
|----------|-------|-----------|------------|-------------|------------|-------|---------|
| `claude-opus-4-6` | — | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| `claude-opus-4-6[1m]` | — | **$10.00** | **$37.50** | **$12.50** | **$1.00** | 37.2 | 5.8s |
| `claude-sonnet-4-6` | — | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| `claude-sonnet-4-6[1m]` | — | **$6.00** | **$22.50** | **$7.50** | **$0.60** | 39.6 | 4.7s |
| `claude-haiku-4-5-20251001` | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| `claude-sonnet-4-5-20250929` | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| `claude-opus-4-5-20251101` | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Жирным** выделены цены `[1m]` вариантов — они x2 от стандартных.

> **На Spark НЕТ:** gpt-5, gpt-5-mini, gpt-5.1, gpt-5.2, gpt-5.4, gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex. Для этих моделей используйте Alpha.

### Пример использования

```bash
curl https://gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 4096,
    "messages": [
      {"role": "user", "content": "Проанализируй эту кодовую базу и предложи архитектурные улучшения..."}
    ]
  }'
```

## Delta

| Параметр | Значение |
|----------|----------|
| Статус | **Не доступен** |
| Доступ | Закрытый канал |

Delta — непубличный канал, который в настоящий момент недоступен. Информация будет опубликована позднее.

## Сравнение каналов

| | Alpha | Spark |
|--|-------|-------|
| Цена | x0.3 | x1 |
| Контекст | 200K | 1M |
| [1m] модели | Нет | Да (x2) |
| Anthropic модели | Все | Все |
| OpenAI GPT модели | Все | **НЕТ** |
| Codex модели | Все (через /v1/responses) | **НЕТ** |
| Лучше для | Ежедневная работа | Большие задачи (Claude) |

## Как выбрать

1. **Начни с Alpha.** Для 90% задач хватает 200K контекста, а цена в 3 раза ниже.
2. **Переключись на Spark**, если получаешь ошибку "context too large" или работаешь с большой кодовой базой.
3. **Используй [1m] модели на Spark**, когда нужен максимальный контекст (анализ репозиториев, длинные документы).

Переключение между каналами — это просто смена `/alpha` на `/spark` в URL. Никаких дополнительных настроек не требуется.

---

# Channels

> Last updated: March 24, 2026

Channels determine pricing and context window limits. The channel is selected as part of the URL path when calling the API.

## URL Format

```
https://{gateway}/{channel}/v1/messages
```

Example:

```
https://gateway.nekocode.app/alpha/v1/messages
```

## Alpha

| Parameter | Value |
|-----------|-------|
| URL suffix | `/alpha` |
| Price multiplier | **x0.3** (70% discount) |
| Context window | 200K tokens |
| Models | All Anthropic + all OpenAI + all Codex |
| APIs | Anthropic Messages, OpenAI Chat Completions, OpenAI Responses |
| Purpose | Daily work, development, code review |

Alpha is the primary channel for everyday use. The price is 30% of the standard API cost, making it ideal for:

- Writing and refactoring code
- Daily interaction with AI assistants (Claude Code, Cursor, Aider)
- Tasks that don't require extremely large context
- Prototyping and experimentation

### Usage Example

```bash
curl https://gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [
      {"role": "user", "content": "Write a sorting function in Python"}
    ]
  }'
```

## Spark

| Parameter | Value |
|-----------|-------|
| URL suffix | `/spark` |
| Price multiplier | **x1** (standard price) |
| Context window | **1M tokens** (for Claude models) |
| Models | **Anthropic Claude only** |
| APIs | Anthropic Messages API only |
| Purpose | Large codebases, long documents, complex analysis |

> **IMPORTANT:** Spark supports **only Anthropic Claude models**. OpenAI GPT and Codex models **do NOT work** on Spark (returns 400/500 error). Use Alpha for GPT/Codex.

Spark provides full access to the extended 1 million token context window for Claude models. This is critical for:

- Working with large codebases (Claude Code on big projects)
- Analyzing long documents and reports
- Complex tasks requiring extensive context
- Cases where Alpha returns "context too large" error

### Full Spark Model List

Endpoint: `POST /spark/v1/messages` (Anthropic Messages API only)

| Model ID | Alias | Input $/1M | Output $/1M | Cache Write | Cache Read | tok/s | Latency |
|----------|-------|-----------|------------|-------------|------------|-------|---------|
| `claude-opus-4-6` | — | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| `claude-opus-4-6[1m]` | — | **$10.00** | **$37.50** | **$12.50** | **$1.00** | 37.2 | 5.8s |
| `claude-sonnet-4-6` | — | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| `claude-sonnet-4-6[1m]` | — | **$6.00** | **$22.50** | **$7.50** | **$0.60** | 39.6 | 4.7s |
| `claude-haiku-4-5-20251001` | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| `claude-sonnet-4-5-20250929` | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| `claude-opus-4-5-20251101` | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Bold** prices are for `[1m]` variants — x2 of standard price.

> **NOT on Spark:** gpt-5, gpt-5-mini, gpt-5.1, gpt-5.2, gpt-5.4, gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex. Use Alpha for these.

### Usage Example

```bash
curl https://gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 4096,
    "messages": [
      {"role": "user", "content": "Analyze this codebase and suggest architectural improvements..."}
    ]
  }'
```

## Delta

| Parameter | Value |
|-----------|-------|
| Status | **Not available** |
| Access | Private channel |

Delta is a non-public channel that is currently unavailable. More information will be published later.

## Channel Comparison

| | Alpha | Spark |
|--|-------|-------|
| Price | x0.3 | x1 |
| Context | 200K | 1M |
| [1m] models | No | Yes (x2) |
| Anthropic models | All | All |
| OpenAI GPT models | All | **NO** |
| Codex models | All (via /v1/responses) | **NO** |
| Best for | Daily work | Large tasks (Claude) |

## How to Choose

1. **Start with Alpha.** For 90% of tasks, 200K context is enough, and the price is 3x lower.
2. **Switch to Spark** if you get a "context too large" error or work with a large codebase.
3. **Use [1m] models on Spark** when you need maximum context (repository analysis, long documents).

Switching between channels is simply changing `/alpha` to `/spark` in the URL. No additional configuration required.
