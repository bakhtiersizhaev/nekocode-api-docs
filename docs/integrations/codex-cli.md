# Codex CLI + Nekocode

> Дата обновления: 24 марта 2026

## Что такое Codex CLI

[Codex CLI](https://github.com/openai/codex) — терминальный AI-агент от OpenAI. Работает с OpenAI-совместимыми API.

## Подключение через Nekocode

> **Проверено:** Codex CLI v0.117 + Nekocode Alpha — все 4 Codex модели работают (gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex). Протестировано 24 марта 2026.

### Шаг 1 — Создайте конфиг

Файл: `~/.codex/config.toml`

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

### Шаг 2 — Задайте API ключ

```bash
export NEKOCODE_API_KEY="sk_live_your_api_key"
```

Добавьте в `~/.zshrc` или `~/.bashrc` для постоянного использования.

### Шаг 3 — Запустите

```bash
codex -m gpt-5.3-codex "ваш промпт"
codex exec -m gpt-5-codex "задача"
```

> **Важно:**
> - Путь конфига — `~/.codex/config.toml` (НЕ `~/.config/codex/`)
> - Поле для ключа — `env_key` (НЕ `env_key_api_key`)
> - Флаг `--provider` не существует в v0.117+, используйте `model_provider` в config.toml
> - Codex модели доступны **только на Alpha канале**

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

> **Verified:** Codex CLI v0.117 + Nekocode Alpha — all 4 Codex models work (gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex). Tested March 24, 2026.

### Step 1 — Create config

File: `~/.codex/config.toml`:

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

### Step 2 — Set API key

```bash
export NEKOCODE_API_KEY="sk_live_your_api_key"
```

Add to `~/.zshrc` or `~/.bashrc` for persistent use.

### Step 3 — Run

```bash
codex -m gpt-5.3-codex "your prompt"
codex exec -m gpt-5-codex "task"
```

> **Important:**
> - Config path is `~/.codex/config.toml` (NOT `~/.config/codex/`)
> - Key field is `env_key` (NOT `env_key_api_key`)
> - `--provider` flag does not exist in v0.117+, use `model_provider` in config.toml
> - Codex models available **only on Alpha channel**

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
