# Прайсинг: Канал Spark (x1)

> Последнее обновление: 24 марта 2026

**Spark** — канал Nekocode API с множителем **x1** (стандартная стоимость провайдера). Включает **только модели Anthropic Claude**. Основное преимущество — полноценная поддержка контекстного окна в **1 миллион токенов** через варианты `[1m]`.

## Когда выбирать Spark

- **Анализ больших документов** — загрузите в контекст целую кодовую базу, книгу или корпус документов (до 1M токенов)
- **Длинные диалоги** — сессии, которые выходят за рамки 200K токенов стандартного контекста
- **Работа с [1m] моделями** — варианты с расширенным контекстом доступны только в этом канале с полным качеством
- **Когда нужна Anthropic** — если ваш воркфлоу завязан на Claude и нужен стандартный прайсинг

## Ценообразование [1m] вариантов

Варианты с суффиксом **[1m]** имеют повышенную стоимость по сравнению с базовой моделью. Множители различаются по категориям:

| Категория | Множитель [1m] |
|-----------|---------------|
| Input | **x2** |
| Output | **x1.5** |
| Cache Write | **x2** |
| Cache Read | **x2** |

**Пример (Claude Opus 4.6):**
- Input: $5.00 → $10.00 (x2)
- Output: $25.00 → $37.50 (x1.5)
- Cache Write: $6.25 → $12.50 (x2)
- Cache Read: $0.50 → $1.00 (x2)

## Полная таблица цен

Все цены указаны в USD за 1M токенов.

| Модель | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $10.00 | $37.50 | $12.50 | $1.00 | 37.2 | 5.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $6.00 | $22.50 | $7.50 | $0.60 | 39.6 | 4.7s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Примечание:** Прочерк (—) означает, что бенчмарк для данной модели в канале Spark пока не проведён.

## Сравнение базовых и [1m] вариантов

| Модель | Вариант | Input | Output | Cache Write | Cache Read |
|--------|---------|-------|--------|-------------|------------|
| Claude Opus 4.6 | Базовая | $5.00 | $25.00 | $6.25 | $0.50 |
| Claude Opus 4.6 | [1M] | $10.00 (+100%) | $37.50 (+50%) | $12.50 (+100%) | $1.00 (+100%) |
| Claude Sonnet 4.6 | Базовая | $3.00 | $15.00 | $3.75 | $0.30 |
| Claude Sonnet 4.6 | [1M] | $6.00 (+100%) | $22.50 (+50%) | $7.50 (+100%) | $0.60 (+100%) |

## Spark vs Alpha: когда что выбирать

| Критерий | Alpha (x0.3) | Spark (x1) |
|----------|-------------|------------|
| Множитель | x0.3 (самый дешёвый) | x1 (стандартный) |
| Провайдеры | Anthropic + OpenAI | Только Anthropic |
| Контекстное окно | До 200K | До 1M (через [1m]) |
| Лучше для | 99% задач, экономия | Анализ огромных документов |
| Базовые цены | Идентичны | Идентичны |
| Цены [1m] | Идентичны базовым | Удвоенные (x2) |

### Когда оставаться на Alpha

- Контекст до 200K токенов
- Нужны модели OpenAI
- Приоритет — экономия

### Когда переходить на Spark

- Нужен контекст свыше 200K токенов
- Работаете только с Claude
- Анализируете большие кодовые базы или документы целиком

## Рекомендации по [1m] моделям

| Задача | Рекомендуемая модель | Стоимость (Input) |
|--------|---------------------|-------------------|
| Анализ большой кодовой базы | `claude-opus-4-6[1m]` | $10.00 / 1M |
| Суммаризация длинных документов | `claude-sonnet-4-6[1m]` | $6.00 / 1M |
| Работа с полным репозиторием | `claude-opus-4-6[1m]` | $10.00 / 1M |
| Длинный технический диалог | `claude-sonnet-4-6[1m]` | $6.00 / 1M |

> Для стандартных задач без потребности в длинном контексте рекомендуется [канал Alpha](./alpha.md).

---

# Pricing: Spark Channel (x1)

> Last updated: March 24, 2026

**Spark** is a Nekocode API channel with an **x1** multiplier (standard provider pricing). Includes **Anthropic Claude models only**. The primary advantage is full support for a **1 million token** context window through `[1m]` variants.

## When to Choose Spark

- **Large document analysis** — load an entire codebase, book, or document corpus into context (up to 1M tokens)
- **Long conversations** — sessions that exceed the 200K token standard context limit
- **Working with [1m] models** — extended context variants are available in this channel at full quality
- **When you need Anthropic** — if your workflow is built around Claude and you need standard pricing

## [1m] Variant Pricing

Variants with the **[1m]** suffix have increased pricing compared to the base model. Multipliers differ by category:

| Category | [1m] Multiplier |
|----------|----------------|
| Input | **x2** |
| Output | **x1.5** |
| Cache Write | **x2** |
| Cache Read | **x2** |

**Example (Claude Opus 4.6):**
- Input: $5.00 → $10.00 (x2)
- Output: $25.00 → $37.50 (x1.5)
- Cache Write: $6.25 → $12.50 (x2)
- Cache Read: $0.50 → $1.00 (x2)

## Full Pricing Table

All prices in USD per 1M tokens.

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 32.7 | 3.9s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $10.00 | $37.50 | $12.50 | $1.00 | 37.2 | 5.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 36.5 | 3.1s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $6.00 | $22.50 | $7.50 | $0.60 | 39.6 | 4.7s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 44.0 | 2.5s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | — | — |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | — | — |

> **Note:** A dash (—) means the benchmark for that model on the Spark channel has not been run yet.

## Base vs [1m] Variant Comparison

| Model | Variant | Input | Output | Cache Write | Cache Read |
|-------|---------|-------|--------|-------------|------------|
| Claude Opus 4.6 | Base | $5.00 | $25.00 | $6.25 | $0.50 |
| Claude Opus 4.6 | [1M] | $10.00 (+100%) | $37.50 (+50%) | $12.50 (+100%) | $1.00 (+100%) |
| Claude Sonnet 4.6 | Base | $3.00 | $15.00 | $3.75 | $0.30 |
| Claude Sonnet 4.6 | [1M] | $6.00 (+100%) | $22.50 (+50%) | $7.50 (+100%) | $0.60 (+100%) |

## Spark vs Alpha: When to Use Which

| Criterion | Alpha (x0.3) | Spark (x1) |
|-----------|-------------|------------|
| Multiplier | x0.3 (cheapest) | x1 (standard) |
| Providers | Anthropic + OpenAI | Anthropic only |
| Context window | Up to 200K | Up to 1M (via [1m]) |
| Best for | 99% of tasks, cost savings | Massive document analysis |
| Base prices | Identical | Identical |
| [1m] prices | Same as base | Doubled (x2) |

### When to Stay on Alpha

- Context up to 200K tokens
- Need OpenAI models
- Priority is cost savings

### When to Switch to Spark

- Need context exceeding 200K tokens
- Working exclusively with Claude
- Analyzing large codebases or full documents

## [1m] Model Recommendations

| Task | Recommended Model | Cost (Input) |
|------|-------------------|--------------|
| Large codebase analysis | `claude-opus-4-6[1m]` | $10.00 / 1M |
| Long document summarization | `claude-sonnet-4-6[1m]` | $6.00 / 1M |
| Full repository work | `claude-opus-4-6[1m]` | $10.00 / 1M |
| Extended technical conversation | `claude-sonnet-4-6[1m]` | $6.00 / 1M |

> For standard tasks without long context needs, the [Alpha channel](./alpha.md) is recommended.
