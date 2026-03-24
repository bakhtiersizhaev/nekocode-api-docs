# Модели OpenAI GPT

> Последнее обновление: 24 марта 2026

Все модели семейства OpenAI GPT, доступные через Nekocode API. Модели OpenAI доступны **только в канале Alpha** (множитель x0.3). Канал Spark предназначен исключительно для моделей Anthropic.

## Обзор линейки

- **GPT-5** — базовая модель пятого поколения. Существенный скачок качества по сравнению с GPT-4o. Хорошая скорость генерации.
- **GPT-5 Mini** — компактная версия GPT-5. Самая дешёвая модель OpenAI в каталоге. Высокая скорость (77.5 tok/s), но повышенная задержка первого токена.
- **GPT-5 Codex** — модификация GPT-5, оптимизированная для генерации и анализа кода.
- **GPT-5.1** — улучшенная версия GPT-5 с повышенной точностью рассуждений.
- **GPT-5.1 Codex** — кодовая модификация GPT-5.1.
- **GPT-5.2** — следующая итерация с улучшенным следованием инструкциям и расширенными знаниями.
- **GPT-5.2 Codex** — кодовая модификация GPT-5.2.
- **GPT-5.3 Codex** — кодовая модель на базе GPT-5.3. Доступны бенчмарки: 41.1 tok/s, задержка 2.5s.
- **GPT-5.4** — новейшая модель в линейке (март 2026). Самая дорогая, но и самая качественная модель OpenAI.

> **Примечание:** Модели OpenAI не имеют стоимости Cache Write (всегда $0). Кэширование на стороне OpenAI — бесплатная запись, платное чтение.

## Канал Alpha (x0.3)

Все цены указаны в USD за 1M токенов.

| Модель | Полный ID | Алиас | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|-----------|-------|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | — | $1.07 | $8.50 | $0 | $0.11 | 55.2 | 4.4s |
| GPT-5 Mini | `gpt-5-mini-2025-08-07` | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 77.5 | 19.2s |
| GPT-5 Codex | `gpt-5-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1-2025-11-13` | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2-2025-12-11` | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | — | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | — | $1.74 | $14.00 | $0 | $0.17 | 41.1 | 2.5s |
| GPT-5.4 | `gpt-5.4-2026-03-05` | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 50.4 | 21.3s |

## Варианты Codex

Модели с суффиксом **Codex** специально оптимизированы для задач программирования:

- Улучшенная генерация кода на популярных языках (Python, TypeScript, Rust, Go и др.)
- Более точное следование техническим инструкциям
- Лучшее понимание структуры кодовой базы
- Цена обычно совпадает с базовой моделью того же поколения

> **КРИТИЧЕСКИ ВАЖНО:**
> 1. Codex модели работают **ТОЛЬКО** через OpenAI Responses API (`/v1/responses`). Через `/v1/chat/completions` вернётся `model_not_found`.
> 2. `max_output_tokens` для Codex моделей должен быть **>= 16**, иначе ошибка.
> 3. Codex модели доступны **только в Alpha канале**. На Spark вернётся ошибка 400/500.

### Эндпоинты по типам моделей

| Тип модели | Эндпоинт | Пример |
|-----------|----------|--------|
| GPT обычные (gpt-5, gpt-5-mini, gpt-5.1, gpt-5.2, gpt-5.4) | `/v1/chat/completions` | `POST /alpha/v1/chat/completions` |
| GPT Codex (gpt-5-codex, gpt-5.1-codex и т.д.) | `/v1/responses` | `POST /alpha/v1/responses` |

## Алиасы

Для удобства доступны короткие алиасы:

| Алиас | Указывает на |
|-------|-------------|
| `gpt-5-mini` | `gpt-5-mini-2025-08-07` |
| `gpt-5.1` | `gpt-5.1-2025-11-13` |
| `gpt-5.2` | `gpt-5.2-2025-12-11` |
| `gpt-5.4` | `gpt-5.4-2026-03-05` |

## Рекомендации по выбору

| Задача | Рекомендуемая модель | Обоснование |
|--------|---------------------|-------------|
| Общие задачи, чат | GPT-5 | Лучшее соотношение цена/качество |
| Высоконагруженные чат-боты | GPT-5 Mini | Самая дешёвая, высокий tok/s |
| Генерация кода | GPT-5.3 Codex | Быстрая, оптимизирована под код |
| Максимальное качество | GPT-5.4 | Новейшая, самая точная |
| Кодинг при ограниченном бюджете | GPT-5 Codex | Дешевле, чем 5.2/5.3 Codex |

---

# OpenAI GPT Models

> Last updated: March 24, 2026

All OpenAI GPT family models available through Nekocode API. OpenAI models are available **only on the Alpha channel** (x0.3 multiplier). The Spark channel is exclusively for Anthropic models.

## Model Lineup

- **GPT-5** — fifth-generation base model. Significant quality leap over GPT-4o. Good generation speed.
- **GPT-5 Mini** — compact version of GPT-5. Cheapest OpenAI model in the catalog. High speed (77.5 tok/s) but elevated time-to-first-token latency.
- **GPT-5 Codex** — GPT-5 variant optimized for code generation and analysis.
- **GPT-5.1** — improved GPT-5 with enhanced reasoning accuracy.
- **GPT-5.1 Codex** — code-optimized variant of GPT-5.1.
- **GPT-5.2** — next iteration with improved instruction following and expanded knowledge.
- **GPT-5.2 Codex** — code-optimized variant of GPT-5.2.
- **GPT-5.3 Codex** — code model based on GPT-5.3. Benchmarks available: 41.1 tok/s, 2.5s latency.
- **GPT-5.4** — the newest model in the lineup (March 2026). The most expensive but highest-quality OpenAI model.

> **Note:** OpenAI models have no Cache Write pricing (always $0). Caching on OpenAI's side means free writes, paid reads.

## Alpha Channel (x0.3)

All prices in USD per 1M tokens.

| Model | Full ID | Alias | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|---------|-------|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | — | $1.07 | $8.50 | $0 | $0.11 | 55.2 | 4.4s |
| GPT-5 Mini | `gpt-5-mini-2025-08-07` | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 77.5 | 19.2s |
| GPT-5 Codex | `gpt-5-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1-2025-11-13` | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | — | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2-2025-12-11` | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | — | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | — | $1.74 | $14.00 | $0 | $0.17 | 41.1 | 2.5s |
| GPT-5.4 | `gpt-5.4-2026-03-05` | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 50.4 | 21.3s |

## Codex Variants

Models with the **Codex** suffix are specifically optimized for programming tasks:

- Improved code generation across popular languages (Python, TypeScript, Rust, Go, etc.)
- More precise technical instruction following
- Better understanding of codebase structure
- Pricing typically matches the base model of the same generation

## Aliases

Short aliases are available for convenience:

| Alias | Points to |
|-------|-----------|
| `gpt-5-mini` | `gpt-5-mini-2025-08-07` |
| `gpt-5.1` | `gpt-5.1-2025-11-13` |
| `gpt-5.2` | `gpt-5.2-2025-12-11` |
| `gpt-5.4` | `gpt-5.4-2026-03-05` |

## Selection Guide

| Task | Recommended Model | Reasoning |
|------|-------------------|-----------|
| General tasks, chat | GPT-5 | Best price/quality ratio |
| High-volume chatbots | GPT-5 Mini | Cheapest, high tok/s |
| Code generation | GPT-5.3 Codex | Fast, code-optimized |
| Maximum quality | GPT-5.4 | Newest, most accurate |
| Coding on a budget | GPT-5 Codex | Cheaper than 5.2/5.3 Codex |
