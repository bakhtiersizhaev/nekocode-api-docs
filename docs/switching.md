# Переключение и возврат

> Дата: 24 марта 2026

Полное руководство по подключению Nekocode ко всем поддерживаемым инструментам и возврату к стандартным подпискам/API.

## Шлюзы (Gateways)

| Шлюз | URL |
|---|---|
| Default | `gateway.nekocode.app` |
| Russia Primary | `ru.gateway.nekocode.app` |
| Russia #2 | `ru-2.gateway.nekocode.app` |
| Russia #3 | `ru-3.gateway.nekocode.app` |

## Каналы (Channels)

| Канал | Путь | Множитель |
|---|---|---|
| Alpha | `/alpha` | x0.3 |
| Spark | `/spark` | x1 |

---

## 1. Claude Code

### Как подключить Nekocode

Откройте файл `~/.claude/settings.json` и добавьте переменные окружения:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_ВАШ_КЛЮЧ",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

### Как переключить gateway

Измените `ANTHROPIC_BASE_URL`:

```json
"ANTHROPIC_BASE_URL": "https://ru.gateway.nekocode.app/alpha"
```

Другие варианты:
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### Как переключить channel

Замените последний сегмент пути:

```json
"ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/spark"
```

### Как выбрать модель

Claude Code автоматически использует доступные модели. Выбор модели происходит через интерфейс Claude Code (`/model` команда).

### Как вернуть стандартную подписку (REVERT)

Удалите три переменные из `~/.claude/settings.json`:

```json
{
  "env": {}
}
```

Удалите `ANTHROPIC_AUTH_TOKEN`, `ANTHROPIC_BASE_URL` и `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`. Claude Code вернётся к стандартному API Anthropic.

### Как проверить что работает

```bash
claude --version
# Запустите Claude Code и отправьте тестовое сообщение
# В логах должен отображаться gateway.nekocode.app
```

---

## 2. Codex CLI

### Как подключить Nekocode

Вариант A — через переменные окружения:

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha"
export OPENAI_API_KEY="sk_live_ВАШ_КЛЮЧ"
```

Вариант B — через `config.toml`:

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

Затем: `export NEKOCODE_API_KEY="sk_live_ВАШ_КЛЮЧ"` и `codex --provider nekocode`

### Как переключить gateway

```bash
export OPENAI_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/spark"
```

### Как выбрать модель

```bash
codex --model claude-sonnet-4-6
```

### Как вернуть стандартную подписку (REVERT)

```bash
unset OPENAI_BASE_URL
unset OPENAI_API_KEY
```

Или удалите секцию `[provider]` из `config.toml`.

### Как проверить что работает

```bash
echo $OPENAI_BASE_URL
# Должно показать URL nekocode или быть пустым после revert
codex "test message"
```

---

## 3. OpenCode

### Как подключить Nekocode

Отредактируйте `opencode.json`:

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "sk_live_ВАШ_КЛЮЧ",
        "baseURL": "https://gateway.nekocode.app/alpha/v1",
        "headers": {
          "X-Provider": "nekocode"
        }
      }
    }
  }
}
```

> Важно: `baseURL` должен заканчиваться на `/v1`.

### Как переключить gateway

```json
"baseURL": "https://ru.gateway.nekocode.app/alpha/v1"
```

### Как переключить channel

```json
"baseURL": "https://gateway.nekocode.app/spark/v1"
```

### Как выбрать модель

Укажите модель в секции конфига или через интерфейс OpenCode.

### Как вернуть стандартную подписку (REVERT)

Удалите секцию `provider` из `opencode.json`:

```json
{
}
```

OpenCode вернётся к стандартным настройкам провайдера.

### Как проверить что работает

Запустите OpenCode и проверьте, что запросы идут через nekocode gateway. Если видите ошибку "provider not found", убедитесь что `baseURL` заканчивается на `/v1`.

---

## 4. OpenClaw

### Как подключить Nekocode

Отредактируйте `openclaw.json`:

```json
{
  "models": {
    "providers": {
      "nekocode": {
        "baseURL": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_ВАШ_КЛЮЧ",
        "type": "anthropic"
      }
    },
    "fallbacks": ["nekocode", "anthropic"]
  }
}
```

### Как переключить gateway

```json
"baseURL": "https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```json
"baseURL": "https://gateway.nekocode.app/spark"
```

### Как выбрать модель

Модель указывается в конфигурации модели или выбирается в интерфейсе OpenClaw.

### Как вернуть стандартную подписку (REVERT)

Удалите `nekocode` из `providers` и `fallbacks` в `openclaw.json`:

```json
{
  "models": {
    "providers": {
      "anthropic": { ... }
    },
    "fallbacks": ["anthropic"]
  }
}
```

### Как проверить что работает

```bash
# Проверьте openclaw.json
cat openclaw.json | grep nekocode
# Запустите OpenClaw и отправьте тестовый запрос
```

---

## 5. Cursor

### Как подключить Nekocode

1. Откройте Cursor
2. Перейдите в **Settings** > **Models**
3. В поле **Override Base URL** введите: `https://gateway.nekocode.app/alpha`
4. В поле **API Key** введите: `sk_live_ВАШ_КЛЮЧ`
5. Сохраните настройки

### Как переключить gateway

Измените **Override Base URL** на:
- `https://ru.gateway.nekocode.app/alpha`
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### Как переключить channel

Измените последний сегмент в **Override Base URL**:
- `https://gateway.nekocode.app/spark`

### Как выбрать модель

В настройках Cursor выберите нужную модель из списка или введите ID модели вручную.

### Как вернуть стандартную подписку (REVERT)

1. Откройте **Settings** > **Models**
2. Очистите поле **Override Base URL** (оставьте пустым)
3. Очистите поле **API Key** (или введите свой ключ Anthropic)
4. Сохраните настройки

Cursor вернётся к использованию стандартного API.

### Как проверить что работает

Отправьте тестовый запрос в Cursor. В статус-баре должна отображаться подключённая модель.

---

## 6. Aider

### Как подключить Nekocode

Вариант A — через переменную окружения:

```bash
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
export ANTHROPIC_API_KEY="sk_live_ВАШ_КЛЮЧ"
```

Вариант B — через флаг:

```bash
aider --api-base "https://gateway.nekocode.app/alpha" --api-key "sk_live_ВАШ_КЛЮЧ"
```

### Как переключить gateway

```bash
export ANTHROPIC_API_BASE="https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```bash
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/spark"
```

### Как выбрать модель

```bash
aider --model claude-sonnet-4-6
```

### Как вернуть стандартную подписку (REVERT)

```bash
unset ANTHROPIC_API_BASE
unset ANTHROPIC_API_KEY
```

Или уберите флаги `--api-base` и `--api-key` из команды запуска. Aider вернётся к стандартному API Anthropic.

### Как проверить что работает

```bash
echo $ANTHROPIC_API_BASE
aider --version
# Запустите aider и проверьте подключение
```

---

## 7. Windsurf

### Как подключить Nekocode

1. Откройте Windsurf
2. Перейдите в **Settings** > **AI Provider** > **Custom**
3. Введите **Base URL**: `https://gateway.nekocode.app/alpha`
4. Введите **API Key**: `sk_live_ВАШ_КЛЮЧ`
5. Сохраните настройки

### Как переключить gateway

Измените **Base URL** на один из российских шлюзов:
- `https://ru.gateway.nekocode.app/alpha`
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### Как переключить channel

Измените последний сегмент **Base URL**:
- `https://gateway.nekocode.app/spark`

### Как выбрать модель

Выберите модель в настройках Windsurf AI Provider.

### Как вернуть стандартную подписку (REVERT)

1. Перейдите в **Settings** > **AI Provider**
2. Переключите обратно на встроенный провайдер (сбросьте Custom)
3. Сохраните

### Как проверить что работает

Отправьте тестовый запрос через Windsurf и убедитесь, что ответ приходит.

---

## 8. Continue.dev

### Как подключить Nekocode

Отредактируйте `config.json`:

```json
{
  "models": [
    {
      "title": "Nekocode Claude",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_ВАШ_КЛЮЧ"
    }
  ]
}
```

### Как переключить gateway

```json
"apiBase": "https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```json
"apiBase": "https://gateway.nekocode.app/spark"
```

### Как выбрать модель

Измените поле `model`:

```json
"model": "claude-sonnet-4-6"
```

### Как вернуть стандартную подписку (REVERT)

Удалите модель Nekocode из массива `models` в `config.json` или замените на стандартного провайдера:

```json
{
  "models": [
    {
      "title": "Claude",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiKey": "ВАШ_КЛЮЧ_ANTHROPIC"
    }
  ]
}
```

### Как проверить что работает

В VS Code откройте панель Continue и отправьте тестовое сообщение. Проверьте, что модель "Nekocode Claude" доступна в списке.

---

## 9. Anthropic SDK

### Как подключить Nekocode

Python:

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_ВАШ_КЛЮЧ",
    base_url="https://gateway.nekocode.app/alpha"
)

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Привет!"}]
)
```

TypeScript/JavaScript:

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic({
  apiKey: "sk_live_ВАШ_КЛЮЧ",
  baseURL: "https://gateway.nekocode.app/alpha",
});

const response = await client.messages.create({
  model: "claude-sonnet-4-6",
  max_tokens: 1024,
  messages: [{ role: "user", content: "Привет!" }],
});
```

### Как переключить gateway

```python
base_url="https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```python
base_url="https://gateway.nekocode.app/spark"
```

### Как выбрать модель

Измените параметр `model`:

```python
model="claude-sonnet-4-6"
```

### Как вернуть стандартную подписку (REVERT)

Удалите параметр `base_url`:

```python
client = anthropic.Anthropic(
    api_key="ВАШ_КЛЮЧ_ANTHROPIC"
)
```

```typescript
const client = new Anthropic({
  apiKey: "ВАШ_КЛЮЧ_ANTHROPIC",
});
```

SDK вернётся к стандартному `api.anthropic.com`.

### Как проверить что работает

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=128,
    messages=[{"role": "user", "content": "ping"}]
)
print(response.content[0].text)
```

---

## 10. Terminal / curl

### Как подключить Nekocode

```bash
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/alpha"
export ANTHROPIC_API_KEY="sk_live_ВАШ_КЛЮЧ"
```

Пример запроса:

```bash
curl -X POST "${ANTHROPIC_BASE_URL}/v1/messages" \
  -H "Content-Type: application/json" \
  -H "x-api-key: ${ANTHROPIC_API_KEY}" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Привет!"}]
  }'
```

### Как переключить gateway

```bash
export ANTHROPIC_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

### Как переключить channel

```bash
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/spark"
```

### Как выбрать модель

Измените `model` в теле JSON-запроса.

### Как вернуть стандартную подписку (REVERT)

```bash
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_API_KEY
```

Или установите стандартный URL:

```bash
export ANTHROPIC_BASE_URL="https://api.anthropic.com"
```

### Как проверить что работает

```bash
echo $ANTHROPIC_BASE_URL
curl -s "${ANTHROPIC_BASE_URL}/v1/messages" \
  -H "x-api-key: ${ANTHROPIC_API_KEY}" \
  -H "anthropic-version: 2023-06-01" \
  -H "Content-Type: application/json" \
  -d '{"model":"claude-sonnet-4-6","max_tokens":64,"messages":[{"role":"user","content":"ping"}]}' | head -c 200
```

---

---

# Switching and Reverting

> Date: March 24, 2026

Complete guide for connecting Nekocode to all supported tools and reverting back to standard subscriptions/APIs.

## Gateways

| Gateway | URL |
|---|---|
| Default | `gateway.nekocode.app` |
| Russia Primary | `ru.gateway.nekocode.app` |
| Russia #2 | `ru-2.gateway.nekocode.app` |
| Russia #3 | `ru-3.gateway.nekocode.app` |

## Channels

| Channel | Path | Multiplier |
|---|---|---|
| Alpha | `/alpha` | x0.3 |
| Spark | `/spark` | x1 |

---

## 1. Claude Code

### How to connect Nekocode

Edit `~/.claude/settings.json` and add environment variables:

```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "sk_live_YOUR_KEY",
    "ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/alpha",
    "CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC": "1"
  }
}
```

### How to switch gateway

Change `ANTHROPIC_BASE_URL`:

```json
"ANTHROPIC_BASE_URL": "https://ru.gateway.nekocode.app/alpha"
```

Other options:
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### How to switch channel

Replace the last path segment:

```json
"ANTHROPIC_BASE_URL": "https://gateway.nekocode.app/spark"
```

### How to choose a model

Claude Code automatically uses available models. Choose the model via the Claude Code interface (`/model` command).

### How to revert to standard subscription (REVERT)

Remove the three variables from `~/.claude/settings.json`:

```json
{
  "env": {}
}
```

Remove `ANTHROPIC_AUTH_TOKEN`, `ANTHROPIC_BASE_URL`, and `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`. Claude Code will revert to the standard Anthropic API.

### How to verify it works

```bash
claude --version
# Launch Claude Code and send a test message
# Logs should show gateway.nekocode.app
```

---

## 2. Codex CLI

### How to connect Nekocode

Option A — via environment variables:

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/alpha"
export OPENAI_API_KEY="sk_live_YOUR_KEY"
```

Option B — via `config.toml`:

```toml
model_provider = "nekocode"

[model_providers.nekocode]
name = "Nekocode Gateway"
base_url = "https://gateway.nekocode.app/alpha/v1"
env_key_api_key = "NEKOCODE_API_KEY"
wire_api = "responses"
```

Then: `export NEKOCODE_API_KEY="sk_live_YOUR_KEY"` and `codex --provider nekocode`

### How to switch gateway

```bash
export OPENAI_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```bash
export OPENAI_BASE_URL="https://gateway.nekocode.app/spark"
```

### How to choose a model

```bash
codex --model claude-sonnet-4-6
```

### How to revert to standard subscription (REVERT)

```bash
unset OPENAI_BASE_URL
unset OPENAI_API_KEY
```

Or remove the `[provider]` section from `config.toml`.

### How to verify it works

```bash
echo $OPENAI_BASE_URL
# Should show nekocode URL or be empty after revert
codex "test message"
```

---

## 3. OpenCode

### How to connect Nekocode

Edit `opencode.json`:

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "sk_live_YOUR_KEY",
        "baseURL": "https://gateway.nekocode.app/alpha/v1",
        "headers": {
          "X-Provider": "nekocode"
        }
      }
    }
  }
}
```

> Important: `baseURL` must end with `/v1`.

### How to switch gateway

```json
"baseURL": "https://ru.gateway.nekocode.app/alpha/v1"
```

### How to switch channel

```json
"baseURL": "https://gateway.nekocode.app/spark/v1"
```

### How to choose a model

Specify the model in the config section or through the OpenCode interface.

### How to revert to standard subscription (REVERT)

Remove the `provider` section from `opencode.json`:

```json
{
}
```

OpenCode will revert to default provider settings.

### How to verify it works

Launch OpenCode and verify that requests go through the nekocode gateway. If you see a "provider not found" error, make sure `baseURL` ends with `/v1`.

---

## 4. OpenClaw

### How to connect Nekocode

Edit `openclaw.json`:

```json
{
  "models": {
    "providers": {
      "nekocode": {
        "baseURL": "https://gateway.nekocode.app/alpha",
        "apiKey": "sk_live_YOUR_KEY",
        "type": "anthropic"
      }
    },
    "fallbacks": ["nekocode", "anthropic"]
  }
}
```

### How to switch gateway

```json
"baseURL": "https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```json
"baseURL": "https://gateway.nekocode.app/spark"
```

### How to choose a model

The model is specified in the model configuration or selected in the OpenClaw interface.

### How to revert to standard subscription (REVERT)

Remove `nekocode` from `providers` and `fallbacks` in `openclaw.json`:

```json
{
  "models": {
    "providers": {
      "anthropic": { ... }
    },
    "fallbacks": ["anthropic"]
  }
}
```

### How to verify it works

```bash
# Check openclaw.json
cat openclaw.json | grep nekocode
# Launch OpenClaw and send a test request
```

---

## 5. Cursor

### How to connect Nekocode

1. Open Cursor
2. Go to **Settings** > **Models**
3. In the **Override Base URL** field, enter: `https://gateway.nekocode.app/alpha`
4. In the **API Key** field, enter: `sk_live_YOUR_KEY`
5. Save settings

### How to switch gateway

Change **Override Base URL** to:
- `https://ru.gateway.nekocode.app/alpha`
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### How to switch channel

Change the last segment of **Override Base URL**:
- `https://gateway.nekocode.app/spark`

### How to choose a model

Select the desired model in Cursor's model settings or enter the model ID manually.

### How to revert to standard subscription (REVERT)

1. Go to **Settings** > **Models**
2. Clear the **Override Base URL** field (leave empty)
3. Clear the **API Key** field (or enter your Anthropic key)
4. Save settings

Cursor will revert to using the standard API.

### How to verify it works

Send a test request in Cursor. The connected model should appear in the status bar.

---

## 6. Aider

### How to connect Nekocode

Option A — via environment variable:

```bash
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/alpha"
export ANTHROPIC_API_KEY="sk_live_YOUR_KEY"
```

Option B — via flag:

```bash
aider --api-base "https://gateway.nekocode.app/alpha" --api-key "sk_live_YOUR_KEY"
```

### How to switch gateway

```bash
export ANTHROPIC_API_BASE="https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```bash
export ANTHROPIC_API_BASE="https://gateway.nekocode.app/spark"
```

### How to choose a model

```bash
aider --model claude-sonnet-4-6
```

### How to revert to standard subscription (REVERT)

```bash
unset ANTHROPIC_API_BASE
unset ANTHROPIC_API_KEY
```

Or remove the `--api-base` and `--api-key` flags from your launch command. Aider will revert to the standard Anthropic API.

### How to verify it works

```bash
echo $ANTHROPIC_API_BASE
aider --version
# Launch aider and verify the connection
```

---

## 7. Windsurf

### How to connect Nekocode

1. Open Windsurf
2. Go to **Settings** > **AI Provider** > **Custom**
3. Enter **Base URL**: `https://gateway.nekocode.app/alpha`
4. Enter **API Key**: `sk_live_YOUR_KEY`
5. Save settings

### How to switch gateway

Change **Base URL** to one of the Russian gateways:
- `https://ru.gateway.nekocode.app/alpha`
- `https://ru-2.gateway.nekocode.app/alpha`
- `https://ru-3.gateway.nekocode.app/alpha`

### How to switch channel

Change the last segment of **Base URL**:
- `https://gateway.nekocode.app/spark`

### How to choose a model

Select the model in Windsurf AI Provider settings.

### How to revert to standard subscription (REVERT)

1. Go to **Settings** > **AI Provider**
2. Switch back to the built-in provider (reset Custom)
3. Save

### How to verify it works

Send a test request through Windsurf and verify that a response is received.

---

## 8. Continue.dev

### How to connect Nekocode

Edit `config.json`:

```json
{
  "models": [
    {
      "title": "Nekocode Claude",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiBase": "https://gateway.nekocode.app/alpha",
      "apiKey": "sk_live_YOUR_KEY"
    }
  ]
}
```

### How to switch gateway

```json
"apiBase": "https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```json
"apiBase": "https://gateway.nekocode.app/spark"
```

### How to choose a model

Change the `model` field:

```json
"model": "claude-sonnet-4-6"
```

### How to revert to standard subscription (REVERT)

Remove the Nekocode model from the `models` array in `config.json` or replace it with a standard provider:

```json
{
  "models": [
    {
      "title": "Claude",
      "provider": "anthropic",
      "model": "claude-sonnet-4-6",
      "apiKey": "YOUR_ANTHROPIC_KEY"
    }
  ]
}
```

### How to verify it works

In VS Code, open the Continue panel and send a test message. Verify that the "Nekocode Claude" model is available in the list.

---

## 9. Anthropic SDK

### How to connect Nekocode

Python:

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_YOUR_KEY",
    base_url="https://gateway.nekocode.app/alpha"
)

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)
```

TypeScript/JavaScript:

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic({
  apiKey: "sk_live_YOUR_KEY",
  baseURL: "https://gateway.nekocode.app/alpha",
});

const response = await client.messages.create({
  model: "claude-sonnet-4-6",
  max_tokens: 1024,
  messages: [{ role: "user", content: "Hello!" }],
});
```

### How to switch gateway

```python
base_url="https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```python
base_url="https://gateway.nekocode.app/spark"
```

### How to choose a model

Change the `model` parameter:

```python
model="claude-sonnet-4-6"
```

### How to revert to standard subscription (REVERT)

Remove the `base_url` parameter:

```python
client = anthropic.Anthropic(
    api_key="YOUR_ANTHROPIC_KEY"
)
```

```typescript
const client = new Anthropic({
  apiKey: "YOUR_ANTHROPIC_KEY",
});
```

The SDK will revert to the standard `api.anthropic.com`.

### How to verify it works

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=128,
    messages=[{"role": "user", "content": "ping"}]
)
print(response.content[0].text)
```

---

## 10. Terminal / curl

### How to connect Nekocode

```bash
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/alpha"
export ANTHROPIC_API_KEY="sk_live_YOUR_KEY"
```

Example request:

```bash
curl -X POST "${ANTHROPIC_BASE_URL}/v1/messages" \
  -H "Content-Type: application/json" \
  -H "x-api-key: ${ANTHROPIC_API_KEY}" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 1024,
    "messages": [{"role": "user", "content": "Hello!"}]
  }'
```

### How to switch gateway

```bash
export ANTHROPIC_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

### How to switch channel

```bash
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/spark"
```

### How to choose a model

Change `model` in the JSON request body.

### How to revert to standard subscription (REVERT)

```bash
unset ANTHROPIC_BASE_URL
unset ANTHROPIC_API_KEY
```

Or set the standard URL:

```bash
export ANTHROPIC_BASE_URL="https://api.anthropic.com"
```

### How to verify it works

```bash
echo $ANTHROPIC_BASE_URL
curl -s "${ANTHROPIC_BASE_URL}/v1/messages" \
  -H "x-api-key: ${ANTHROPIC_API_KEY}" \
  -H "anthropic-version: 2023-06-01" \
  -H "Content-Type: application/json" \
  -d '{"model":"claude-sonnet-4-6","max_tokens":64,"messages":[{"role":"user","content":"ping"}]}' | head -c 200
```
