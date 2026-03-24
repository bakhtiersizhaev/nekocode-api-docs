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
| Модели | Все модели Anthropic + OpenAI |
| Назначение | Ежедневная работа, разработка, код-ревью |

Alpha — основной канал для повседневного использования. Цена составляет 30% от стандартной стоимости API, что делает его идеальным для:

- Написания и рефакторинга кода
- Ежедневного взаимодействия с AI-ассистентами (Claude Code, Cursor, Aider)
- Задач, не требующих сверхбольшого контекста
- Прототипирования и экспериментов

### Пример использования

```bash
curl https://ru.gateway.nekocode.app/alpha/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-20250514",
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
| Модели | Все модели Anthropic + OpenAI |
| Назначение | Большие кодовые базы, длинные документы, сложный анализ |

Spark предоставляет полный доступ к расширенному контекстному окну в 1 миллион токенов для моделей Claude. Это критически важно для:

- Работы с большими кодовыми базами (Claude Code на крупных проектах)
- Анализа длинных документов и отчётов
- Сложных задач, требующих обширного контекста
- Случаев, когда Alpha выдаёт ошибку "context too large"

### Модели с расширенным контекстом [1m]

Для использования 1M контекстного окна на канале Spark доступны специальные варианты моделей с суффиксом `[1m]`. Тарификация для `[1m]` вариантов — **x2** от стандартной цены модели.

| Модель | Контекст | Цена (Spark) |
|--------|----------|-------------|
| `claude-sonnet-4-20250514` | 200K | x1 |
| `claude-sonnet-4-20250514 [1m]` | 1M | x2 |
| `claude-opus-4-20250514` | 200K | x1 |
| `claude-opus-4-20250514 [1m]` | 1M | x2 |

### Пример использования

```bash
curl https://ru.gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-20250514",
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
| OpenAI модели | Все | Все |
| Лучше для | Ежедневная работа | Большие задачи |

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
| Models | All Anthropic + OpenAI models |
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
    "model": "claude-sonnet-4-20250514",
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
| Models | All Anthropic + OpenAI models |
| Purpose | Large codebases, long documents, complex analysis |

Spark provides full access to the extended 1 million token context window for Claude models. This is critical for:

- Working with large codebases (Claude Code on big projects)
- Analyzing long documents and reports
- Complex tasks requiring extensive context
- Cases where Alpha returns "context too large" error

### Extended Context [1m] Models

To use the 1M context window on the Spark channel, special model variants with the `[1m]` suffix are available. Pricing for `[1m]` variants is **x2** the standard model price.

| Model | Context | Price (Spark) |
|-------|---------|---------------|
| `claude-sonnet-4-20250514` | 200K | x1 |
| `claude-sonnet-4-20250514 [1m]` | 1M | x2 |
| `claude-opus-4-20250514` | 200K | x1 |
| `claude-opus-4-20250514 [1m]` | 1M | x2 |

### Usage Example

```bash
curl https://gateway.nekocode.app/spark/v1/messages \
  -H "Content-Type: application/json" \
  -H "x-api-key: sk_live_YOUR_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-20250514",
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
| OpenAI models | All | All |
| Best for | Daily work | Large tasks |

## How to Choose

1. **Start with Alpha.** For 90% of tasks, 200K context is enough, and the price is 3x lower.
2. **Switch to Spark** if you get a "context too large" error or work with a large codebase.
3. **Use [1m] models on Spark** when you need maximum context (repository analysis, long documents).

Switching between channels is simply changing `/alpha` to `/spark` in the URL. No additional configuration required.
