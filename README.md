<div align="center">

# nekocode-api-docs

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Last Updated](https://img.shields.io/badge/Updated-March%202026-blue.svg)](#)

**Неофициальная документация и инструменты для Nekocode AI Gateway**

[nekocode.app](https://nekocode.app) | [Telegram @nekocode_app](https://t.me/nekocode_app) | [Status @nekocode_status](https://t.me/nekocode_status) | [status.nekocode.app](https://status.nekocode.app)

</div>

---

## Что такое Nekocode?

[Nekocode](https://nekocode.app) — единый AI-шлюз (gateway), который предоставляет доступ к моделям **Anthropic Claude** и **OpenAI GPT** через один API-ключ.

- **Один ключ** — доступ ко всем моделям Anthropic и OpenAI
- **Множество шлюзов** — глобальный (EU/US) + 3 российских для обхода ограничений и низкой задержки
- **Два канала** — **Alpha** (x0.3 от стоимости, 200K контекст) и **Spark** (x1, до 1M токенов контекста)
- **Drop-in совместимость** — работает с любым инструментом, поддерживающим Anthropic или OpenAI API

---

## Быстрый старт

### 1. Регистрация

Перейди на [nekocode.app](https://nekocode.app) и создай аккаунт (доступна авторизация через Telegram).

### 2. Получи API-ключ

Открой [Dashboard → API Keys](https://nekocode.app/dashboard/api-keys) и создай ключ. Формат: `sk_live_...`

### 3. Настрой инструмент

Укажи базовый URL и ключ в своём инструменте. Пример для Claude Code (`~/.claude/settings.json`):

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_YOUR_KEY",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

Для России замени `gateway.nekocode.app` на `ru.gateway.nekocode.app`.

---

## Поддерживаемые модели

### Anthropic Claude (Alpha, x0.3)

Цены в USD за 1M токенов.

| Модель | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.9 | 5.1s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 39.7 | 4.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 20.7 | 3.5s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 23.1 | 8.5s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 60.7 | 2.9s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.0 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 48.6 | 3.4s |

### OpenAI GPT (Alpha, x0.3)

| Модель | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|--------|----|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | $1.07 | $8.50 | $0 | $0.11 | — | — |
| GPT-5 Mini | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 74.0 | 16.7s |
| GPT-5 Codex | `gpt-5-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | $1.74 | $14.00 | $0 | $0.17 | 37.5 | 2.3s |
| GPT-5.4 | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 24.1 | 28.7s |

> На канале **Spark** (x1) доступны модели Claude с контекстом до 1M токенов. Модели `[1m]` стоят x2 от базовой цены. Подробнее: [docs/pricing/](docs/pricing/)

---

## Интеграции

| Инструмент | Файл конфигурации | Документация |
|------------|-------------------|--------------|
| **Claude Code** | `~/.claude/settings.json` | [docs/integrations/claude-code.md](docs/integrations/claude-code.md) |
| **Codex CLI** | `~/.codex/config.toml` | [docs/integrations/codex-cli.md](docs/integrations/codex-cli.md) |
| **OpenCode** | `opencode.json` | [docs/integrations/opencode.md](docs/integrations/opencode.md) |
| **OpenClaw** | `~/.openclaw/openclaw.json` | [docs/integrations/openclaw.md](docs/integrations/openclaw.md) |
| **Cursor** | Settings → Models | [docs/integrations/cursor.md](docs/integrations/cursor.md) |
| **Aider** | Переменные окружения / `.aider.conf.yml` | [docs/integrations/aider.md](docs/integrations/aider.md) |
| **Windsurf** | Settings → AI Provider | [docs/integrations/windsurf.md](docs/integrations/windsurf.md) |
| **Continue.dev** | `~/.continue/config.json` | [docs/integrations/continue-dev.md](docs/integrations/continue-dev.md) |
| **Anthropic SDK** | Python / TypeScript | [docs/integrations/anthropic-sdk.md](docs/integrations/anthropic-sdk.md) |
| **cURL** | Терминал | [docs/integrations/curl.md](docs/integrations/curl.md) |

Для собственных проектов (боты, веб-приложения, серверлесс): [docs/integrations/custom.md](docs/integrations/custom.md)

---

## Автоматическая установка

```bash
curl -fsSL https://raw.githubusercontent.com/bakhtiersizhaev/nekocode-api-docs/main/scripts/setup.sh | bash
```

Скрипт интерактивно настроит выбранный инструмент (Claude Code, OpenCode, Codex CLI, Aider).

---

## Структура репозитория

```
nekocode-api-docs/
├── configs/                    # Готовые файлы конфигурации
│   ├── claude-code-settings.json
│   ├── codex-config.toml
│   ├── opencode.json
│   ├── openclaw-provider.json
│   ├── aider-env.sh
│   ├── .env.example
│   └── revert/                 # Конфиги для отката к стандартным API
├── docs/
│   ├── quickstart.md           # Быстрый старт
│   ├── channels.md             # Каналы (Alpha, Spark)
│   ├── gateways.md             # Шлюзы (Global, Russia x3)
│   ├── switching.md            # Переключение и откат
│   ├── status.md               # Мониторинг статуса
│   ├── troubleshooting.md      # Устранение неполадок
│   ├── models/
│   │   ├── anthropic.md        # Модели Claude
│   │   └── openai.md           # Модели GPT
│   ├── pricing/
│   │   ├── alpha.md            # Прайсинг Alpha (x0.3)
│   │   └── spark.md            # Прайсинг Spark (x1)
│   └── integrations/           # Инструкции по 10 инструментам + custom
├── scripts/                    # Скрипты автоустановки
├── skill/                      # OpenClaw AI skill
├── LICENSE                     # MIT
├── README.md                   # Этот файл
├── README.ai.md                # AI-оптимизированная версия
└── TODO.md                     # Трекер задач
```

---

## Лицензия

[MIT](LICENSE) — Bakhtier Sizhaev ([@bakhtiersizhaev](https://github.com/bakhtiersizhaev))

---
---

<div align="center">

# nekocode-api-docs

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Last Updated](https://img.shields.io/badge/Updated-March%202026-blue.svg)](#)

**Unofficial documentation and tools for the Nekocode AI Gateway**

[nekocode.app](https://nekocode.app) | [Telegram @nekocode_app](https://t.me/nekocode_app) | [Status @nekocode_status](https://t.me/nekocode_status) | [status.nekocode.app](https://status.nekocode.app)

</div>

---

## What is Nekocode?

[Nekocode](https://nekocode.app) is a unified AI gateway that provides access to **Anthropic Claude** and **OpenAI GPT** models through a single API key.

- **One key** — access to all Anthropic and OpenAI models
- **Multiple gateways** — Global (EU/US) + 3 Russian gateways for bypassing restrictions and low latency
- **Two channels** — **Alpha** (x0.3 price, 200K context) and **Spark** (x1, up to 1M token context)
- **Drop-in compatible** — works with any tool that supports Anthropic or OpenAI API

---

## Quick Start

### 1. Sign Up

Go to [nekocode.app](https://nekocode.app) and create an account (Telegram auth available).

### 2. Get Your API Key

Open [Dashboard → API Keys](https://nekocode.app/dashboard/api-keys) and create a key. Format: `sk_live_...`

### 3. Configure Your Tool

Set the base URL and key in your tool. Example for Claude Code (`~/.claude/settings.json`):

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_YOUR_KEY",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

For Russia, replace `gateway.nekocode.app` with `ru.gateway.nekocode.app`.

---

## Supported Models

### Anthropic Claude (Alpha, x0.3)

Prices in USD per 1M tokens.

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| Claude Opus 4.6 | `claude-opus-4-6` | $5.00 | $25.00 | $6.25 | $0.50 | 37.9 | 5.1s |
| Claude Opus 4.6 [1M] | `claude-opus-4-6[1m]` | $5.00 | $25.00 | $6.25 | $0.50 | 39.7 | 4.8s |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3.00 | $15.00 | $3.75 | $0.30 | 20.7 | 3.5s |
| Claude Sonnet 4.6 [1M] | `claude-sonnet-4-6[1m]` | $3.00 | $15.00 | $3.75 | $0.30 | 23.1 | 8.5s |
| Claude Haiku 4.5 | `claude-haiku-4-5` | $1.00 | $5.00 | $1.25 | $0.10 | 60.7 | 2.9s |
| Claude Sonnet 4.5 | `claude-sonnet-4-5` | $3.00 | $15.00 | $3.75 | $0.30 | 47.0 | 2.4s |
| Claude Opus 4.5 | `claude-opus-4-5` | $5.00 | $25.00 | $6.25 | $0.50 | 48.6 | 3.4s |

### OpenAI GPT (Alpha, x0.3)

| Model | ID | Input | Output | Cache Write | Cache Read | tok/s | Latency |
|-------|----|-------|--------|-------------|------------|-------|---------|
| GPT-5 | `gpt-5` | $1.07 | $8.50 | $0 | $0.11 | — | — |
| GPT-5 Mini | `gpt-5-mini` | $0.25 | $2.00 | $0 | $0.03 | 74.0 | 16.7s |
| GPT-5 Codex | `gpt-5-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 | `gpt-5.1` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.1 Codex | `gpt-5.1-codex` | $1.25 | $10.00 | $0 | $0.13 | — | — |
| GPT-5.2 | `gpt-5.2` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.2 Codex | `gpt-5.2-codex` | $1.75 | $14.00 | $0 | $0.17 | — | — |
| GPT-5.3 Codex | `gpt-5.3-codex` | $1.74 | $14.00 | $0 | $0.17 | 37.5 | 2.3s |
| GPT-5.4 | `gpt-5.4` | $2.50 | $15.00 | $0 | $0.25 | 24.1 | 28.7s |

> On the **Spark** channel (x1), Claude models support up to 1M token context. `[1m]` models cost x2 the base price. Details: [docs/pricing/](docs/pricing/)

---

## Integrations

| Tool | Config file | Documentation |
|------|-------------|---------------|
| **Claude Code** | `~/.claude/settings.json` | [docs/integrations/claude-code.md](docs/integrations/claude-code.md) |
| **Codex CLI** | `~/.codex/config.toml` | [docs/integrations/codex-cli.md](docs/integrations/codex-cli.md) |
| **OpenCode** | `opencode.json` | [docs/integrations/opencode.md](docs/integrations/opencode.md) |
| **OpenClaw** | `~/.openclaw/openclaw.json` | [docs/integrations/openclaw.md](docs/integrations/openclaw.md) |
| **Cursor** | Settings → Models | [docs/integrations/cursor.md](docs/integrations/cursor.md) |
| **Aider** | Environment variables / `.aider.conf.yml` | [docs/integrations/aider.md](docs/integrations/aider.md) |
| **Windsurf** | Settings → AI Provider | [docs/integrations/windsurf.md](docs/integrations/windsurf.md) |
| **Continue.dev** | `~/.continue/config.json` | [docs/integrations/continue-dev.md](docs/integrations/continue-dev.md) |
| **Anthropic SDK** | Python / TypeScript | [docs/integrations/anthropic-sdk.md](docs/integrations/anthropic-sdk.md) |
| **cURL** | Terminal | [docs/integrations/curl.md](docs/integrations/curl.md) |

For custom projects (bots, web apps, serverless): [docs/integrations/custom.md](docs/integrations/custom.md)

---

## Automatic Setup

```bash
curl -fsSL https://raw.githubusercontent.com/bakhtiersizhaev/nekocode-api-docs/main/scripts/setup.sh | bash
```

The script interactively configures your chosen tool (Claude Code, OpenCode, Codex CLI, Aider).

---

## Repository Structure

```
nekocode-api-docs/
├── configs/                    # Ready-to-use configuration files
│   ├── claude-code-settings.json
│   ├── codex-config.toml
│   ├── opencode.json
│   ├── openclaw-provider.json
│   ├── aider-env.sh
│   ├── .env.example
│   └── revert/                 # Configs to revert to standard APIs
├── docs/
│   ├── quickstart.md           # Quick start guide
│   ├── channels.md             # Channels (Alpha, Spark)
│   ├── gateways.md             # Gateways (Global, Russia x3)
│   ├── switching.md            # Switching and reverting
│   ├── status.md               # Status monitoring
│   ├── troubleshooting.md      # Troubleshooting
│   ├── models/
│   │   ├── anthropic.md        # Claude models
│   │   └── openai.md           # GPT models
│   ├── pricing/
│   │   ├── alpha.md            # Alpha pricing (x0.3)
│   │   └── spark.md            # Spark pricing (x1)
│   └── integrations/           # Setup guides for 10 tools + custom
├── scripts/                    # Auto-setup scripts
├── skill/                      # OpenClaw AI skill
├── LICENSE                     # MIT
├── README.md                   # This file
├── README.ai.md                # AI-optimized version
└── TODO.md                     # Task tracker
```

---

## License

[MIT](LICENSE) — Bakhtier Sizhaev ([@bakhtiersizhaev](https://github.com/bakhtiersizhaev))
