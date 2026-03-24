# Codex CLI + Nekocode

> Дата обновления: 24 марта 2026

## Что такое Codex CLI

[Codex CLI](https://github.com/openai/codex) — терминальный AI-агент от OpenAI. Работает с OpenAI-совместимыми API.

## Подключение через Nekocode

Два способа настройки.

### Способ 1 — Переменные окружения

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha/v1"
export OPENAI_API_KEY="sk_live_your_api_key"
codex
```

### Способ 2 — config.toml

Файл: `~/.config/codex/config.toml`

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

Затем задайте ключ и запустите:

```bash
export NEKOCODE_API_KEY="sk_live_your_api_key"
codex --provider nekocode
```

### Каналы

| Канал | URL | Особенности |
|-------|-----|-------------|
| Alpha | `https://gateway.nekocode.app/alpha/v1` | x0.3 от стоимости, все модели |
| Spark | `https://gateway.nekocode.app/spark/v1` | x1, только Claude (GPT/Codex **не работают**) |

> **Важно:** Codex CLI по умолчанию использует Codex модели, которые работают через Responses API (`/v1/responses`). Конфигурация `wire_api = "responses"` в config.toml обеспечивает это. GPT и Codex модели доступны **только на Alpha канале**.

### Шлюз для России

Замените `gateway.nekocode.app` на `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha/v1
```

> **Важно:** URL для Codex CLI должен заканчиваться на `/v1`.

## Откат к стандартному OpenAI

- **Способ 1:** удалите переменные окружения:
  ```bash
  unset OPENAI_BASE_URL
  unset OPENAI_API_KEY
  ```
- **Способ 2:** удалите секцию `[model_providers.nekocode]` из `config.toml`, либо запускайте `codex` без флага `--provider` (используется OpenAI по умолчанию).

---

# Codex CLI + Nekocode

> Updated: March 24, 2026

## What is Codex CLI

[Codex CLI](https://github.com/openai/codex) is a terminal AI agent by OpenAI. Works with OpenAI-compatible APIs.

## Connecting via Nekocode

Two configuration methods.

### Method 1 — Environment variables

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha/v1"
export OPENAI_API_KEY="sk_live_your_api_key"
codex
```

### Method 2 — config.toml

File: `~/.config/codex/config.toml`

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

Then set the key and run:

```bash
export NEKOCODE_API_KEY="sk_live_your_api_key"
codex --provider nekocode
```

### Channels

| Channel | URL | Details |
|---------|-----|---------|
| Alpha | `https://gateway.nekocode.app/alpha/v1` | x0.3 price multiplier |
| Spark | `https://gateway.nekocode.app/spark/v1` | x1 price, up to 1M context |

### Russia gateway

Replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`:

```
https://ru.gateway.nekocode.app/alpha/v1
```

> **Important:** The URL for Codex CLI must end with `/v1`.

## Reverting to standard OpenAI

- **Method 1:** unset environment variables:
  ```bash
  unset OPENAI_BASE_URL
  unset OPENAI_API_KEY
  ```
- **Method 2:** remove the `[model_providers.nekocode]` section from `config.toml`, or run `codex` without the `--provider` flag (defaults to OpenAI).
