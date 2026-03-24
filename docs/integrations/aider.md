# Aider + Nekocode

> Дата обновления: 24 марта 2026

## Что такое Aider

[Aider](https://aider.chat) — open-source AI-инструмент для кодинга в терминале. Работает с репозиторием через git.

## Подключение через Nekocode

Три способа настройки.

### Способ 1 — Переменные окружения

```bash
export ANTHROPIC_API_KEY="sk_live_your_api_key"
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
aider --model claude-sonnet-4-6
```

### Способ 2 — Флаги командной строки

```bash
aider --api-base anthropic=https://gateway.nekocode.app/alpha \
      --api-key anthropic=sk_live_your_api_key \
      --model claude-sonnet-4-6
```

### Способ 3 — .aider.conf.yml

Файл: `.aider.conf.yml` (корень проекта или домашняя директория)

```yaml
api-base:
  anthropic: https://gateway.nekocode.app/alpha
api-key:
  anthropic: sk_live_your_api_key
model: claude-sonnet-4-6
```

### Каналы

| Канал | URL | Особенности |
|-------|-----|-------------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 от стоимости |
| Spark | `https://gateway.nekocode.app/spark` | x1, контекст до 1M токенов |

### Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha
```

## Откат к стандартному Anthropic API

- **Способ 1:** удалите переменные окружения:
  ```bash
  unset ANTHROPIC_API_KEY
  unset ANTHROPIC_API_BASE
  ```
- **Способ 2:** запускайте aider без флагов `--api-base` и `--api-key`.
- **Способ 3:** удалите секции `api-base` и `api-key` из `.aider.conf.yml`, либо укажите стандартный API-ключ Anthropic.

---

# Aider + Nekocode

> Updated: March 24, 2026

## What is Aider

[Aider](https://aider.chat) is an open-source AI coding tool for the terminal. Works with repositories via git.

## Connecting via Nekocode

Three configuration methods.

### Method 1 — Environment variables

```bash
export ANTHROPIC_API_KEY="sk_live_your_api_key"
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
aider --model claude-sonnet-4-6
```

### Method 2 — Command line flags

```bash
aider --api-base anthropic=https://gateway.nekocode.app/alpha \
      --api-key anthropic=sk_live_your_api_key \
      --model claude-sonnet-4-6
```

### Method 3 — .aider.conf.yml

File: `.aider.conf.yml` (project root or home directory)

```yaml
api-base:
  anthropic: https://gateway.nekocode.app/alpha
api-key:
  anthropic: sk_live_your_api_key
model: claude-sonnet-4-6
```

### Channels

| Channel | URL | Details |
|---------|-----|---------|
| Alpha | `https://gateway.nekocode.app/alpha` | x0.3 price multiplier |
| Spark | `https://gateway.nekocode.app/spark` | x1 price, up to 1M context |

### Russia gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha
```

## Reverting to standard Anthropic API

- **Method 1:** unset environment variables:
  ```bash
  unset ANTHROPIC_API_KEY
  unset ANTHROPIC_API_BASE
  ```
- **Method 2:** run aider without `--api-base` and `--api-key` flags.
- **Method 3:** remove the `api-base` and `api-key` sections from `.aider.conf.yml`, or specify a standard Anthropic API key.
