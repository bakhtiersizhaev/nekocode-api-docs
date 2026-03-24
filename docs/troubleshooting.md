# Устранение неполадок

> Дата: 24 марта 2026

Распространённые проблемы и решения при работе с Nekocode.

---

## 1. Ошибка 429 — Rate Limit

**Проблема:** Превышен лимит запросов. Сервер возвращает `429 Too Many Requests`.

**Решения:**

- Подождите несколько секунд и повторите запрос
- Переключитесь на другой шлюз (`ru.gateway.nekocode.app`, `ru-2.gateway.nekocode.app`, `ru-3.gateway.nekocode.app`)
- Переключитесь на другой канал (Alpha / Spark)
- Проверьте, не отправляете ли вы слишком много параллельных запросов

---

## 2. Подключение из России

**Проблема:** Основной шлюз `gateway.nekocode.app` недоступен или работает медленно из России.

**Решения:**

- Используйте российские шлюзы:
  - `ru.gateway.nekocode.app` (Primary)
  - `ru-2.gateway.nekocode.app` (#2)
  - `ru-3.gateway.nekocode.app` (#3)
- Попробуйте каждый шлюз — один может работать быстрее в зависимости от вашего провайдера
- Проверьте статус шлюзов на [status.nekocode.app](https://status.nekocode.app)

---

## 3. Таймаут подключения (Connection Timeout)

**Проблема:** Запросы не получают ответа, соединение разрывается по таймауту.

**Решения:**

- Проверьте текущий статус на [status.nekocode.app](https://status.nekocode.app)
- Проверьте подключение к интернету
- Попробуйте другой шлюз
- Увеличьте таймаут в настройках клиента
- Проверьте, нет ли блокировки на уровне файрвола или прокси

---

## 4. Недействительный API-ключ (Invalid API Key)

**Проблема:** Сервер возвращает ошибку аутентификации.

**Решения:**

- Убедитесь, что ключ начинается с префикса `sk_live_`
- Проверьте ключ в личном кабинете: [nekocode.app/dashboard](https://nekocode.app/dashboard)
- Убедитесь, что в ключе нет лишних пробелов или символов
- Создайте новый ключ, если текущий мог быть скомпрометирован
- Проверьте, что ключ передаётся в правильном заголовке/параметре

---

## 5. Модель не найдена (Model Not Found)

**Проблема:** Сервер возвращает ошибку, что указанная модель не существует.

**Решения:**

- Используйте точный идентификатор модели (например, `claude-sonnet-4-6`, а не `claude-sonnet`)
- **Codex модели** (gpt-5-codex, gpt-5.1-codex и т.д.) работают **ТОЛЬКО** через `/v1/responses`. Через `/v1/chat/completions` вернётся `model_not_found`
- **GPT/Codex модели** доступны **только на Alpha канале**. На Spark вернётся ошибка
- Проверьте доступные модели в документации или личном кабинете
- Убедитесь, что модель доступна на выбранном канале
- Учтите регистр символов — идентификаторы моделей чувствительны к регистру

---

## 6. Высокая задержка (High Latency)

**Проблема:** Запросы выполняются, но с большой задержкой.

**Решения:**

- Используйте канал **Alpha** (оптимизирован для скорости, множитель x0.3)
- Выберите ближайший к вам шлюз:
  - Европа/Глобальный: `gateway.nekocode.app`
  - Россия: `ru.gateway.nekocode.app`, `ru-2.gateway.nekocode.app`, `ru-3.gateway.nekocode.app`
- Уменьшите `max_tokens` если вам не нужны длинные ответы
- Проверьте статус на [status.nekocode.app](https://status.nekocode.app) — возможны временные деградации

---

## 7. Ошибки CORS

**Проблема:** Браузер блокирует запросы к API из-за CORS (Cross-Origin Resource Sharing).

**Решения:**

- API Nekocode предназначен **только для серверных вызовов** (server-side)
- **Не вызывайте API напрямую из браузерного JavaScript**
- Проксируйте запросы через ваш бэкенд:

```javascript
// НЕ ДЕЛАЙТЕ ТАК (клиент):
// fetch("https://gateway.nekocode.app/alpha/v1/messages", ...)

// ДЕЛАЙТЕ ТАК (через свой сервер):
// Клиент -> Ваш бэкенд -> Nekocode API
```

- Настройте прокси в вашем серверном приложении (Express, FastAPI и т.д.)

---

## 8. Claude Code — Extra Usage Required

**Проблема:** Claude Code сообщает, что требуется дополнительное использование ("extra usage required") или контекст слишком велик.

**Решения:**

- Контекст вашего запроса слишком большой для текущего канала
- Переключитесь на канал **Spark** (множитель x1, поддерживает контексты до [1m] токенов)
- Уменьшите контекст, удалив ненужные файлы из контекста беседы
- Используйте `/compact` команду для сжатия истории
- Проверьте баланс в личном кабинете

---

## 9. OpenCode — Provider Not Found

**Проблема:** OpenCode выдаёт ошибку "provider not found" при попытке подключения.

**Решения:**

- Убедитесь, что `baseURL` в `opencode.json` заканчивается суффиксом `/v1`:

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      }
    }
  }
}
```

- Неправильно: `https://gateway.nekocode.app/alpha`
- Правильно: `https://gateway.nekocode.app/alpha/v1`
- Перезапустите OpenCode после изменения конфигурации

---

## 10. Codex CLI — Missing API Key

**Проблема:** Codex CLI сообщает, что API-ключ не найден.

**Решения:**

- Убедитесь, что имя переменной окружения соответствует провайдеру:
  - Для OpenAI-совместимого режима: `OPENAI_API_KEY`
  - Для Anthropic-совместимого режима: `ANTHROPIC_API_KEY`
- Проверьте, что переменные экспортированы в текущей сессии:

```bash
echo $OPENAI_API_KEY
echo $OPENAI_BASE_URL
```

- Если используете `config.toml`, убедитесь что `api_key` указан в правильной секции `[provider]`
- Перезапустите терминал после установки переменных окружения

---

## 11. Codex модели — model_not_found

**Проблема:** При запросе Codex моделей (gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex) через `/v1/chat/completions` возвращается `model_not_found`.

**Решения:**

- Codex модели работают **ТОЛЬКО** через OpenAI Responses API: `/v1/responses`
- Используйте правильный эндпоинт:

```bash
# НЕПРАВИЛЬНО (вернёт model_not_found):
curl .../v1/chat/completions -d '{"model": "gpt-5.3-codex", ...}'

# ПРАВИЛЬНО:
curl .../v1/responses -d '{"model": "gpt-5.3-codex", "max_output_tokens": 4096, "input": "..."}'
```

- `max_output_tokens` для Codex должен быть **>= 16**, иначе ошибка
- Codex модели доступны **только на Alpha канале** (не Spark)
- В OpenCode используйте провайдер `nekocode-codex` с `@ai-sdk/openai` (не `@ai-sdk/openai-compatible`)

---

## 12. GPT модели не работают на Spark

**Проблема:** При использовании GPT или Codex моделей на Spark канале возвращается ошибка 400/500.

**Решение:** Spark поддерживает **только Anthropic Claude модели**. Для GPT и Codex используйте Alpha канал (`/alpha`).

---

## 13. OpenCode + Codex — "Unknown parameter: reasoningSummary"

**Проблема:** При использовании Codex моделей (gpt-5-codex, gpt-5.x-codex) через OpenCode возвращается ошибка `Unknown parameter: 'reasoningSummary'`.

**Причина:** OpenCode добавляет параметры `reasoningSummary` и `reasoningEffort` для GPT-5 моделей, но через `@ai-sdk/openai-compatible` они отправляются как лишние поля в Chat Completions API.

**Решение:** Используйте провайдер `@ai-sdk/openai` (не `@ai-sdk/openai-compatible`) с опциями `responsesApiSupported: true` и `store: false` для Codex моделей:

```json
"nekocode-codex": {
  "npm": "@ai-sdk/openai",
  "options": {
    "apiKey": "sk_live_your_api_key",
    "baseURL": "https://gateway.nekocode.app/alpha/v1"
  },
  "models": {
    "gpt-5.3-codex": {
      "name": "GPT-5.3 Codex",
      "options": { "responsesApiSupported": true, "store": false }
    }
  }
}
```

См. [docs/integrations/opencode.md](../integrations/opencode.md) для полного конфига.

---

## 14. GPT-5.1 — "max_tokens reached" при маленьком значении

**Проблема:** `gpt-5.1` возвращает 400 с сообщением "Could not finish the message because max_tokens or model output limit was reached" при `max_tokens` < ~16.

**Решение:** Установите `max_tokens` >= 16 (рекомендуется >= 100). Некоторые модели не могут сгенерировать ответ в 5 токенов.

---

## Общие советы

- Всегда проверяйте [status.nekocode.app](https://status.nekocode.app) перед диагностикой
- Подпишитесь на @nekocode_status в Telegram для оповещений
- Для вопросов используйте Telegram-канал [t.me/nekocode_app](https://t.me/nekocode_app)
- Ключ API всегда начинается с `sk_live_`

---

---

# Troubleshooting

> Date: March 24, 2026

Common problems and solutions when working with Nekocode.

---

## 1. Error 429 — Rate Limit

**Problem:** Request rate limit exceeded. Server returns `429 Too Many Requests`.

**Solutions:**

- Wait a few seconds and retry the request
- Switch to a different gateway (`ru.gateway.nekocode.app`, `ru-2.gateway.nekocode.app`, `ru-3.gateway.nekocode.app`)
- Switch to a different channel (Alpha / Spark)
- Check if you are sending too many concurrent requests

---

## 2. Network from Russia

**Problem:** The main gateway `gateway.nekocode.app` is unreachable or slow from Russia.

**Solutions:**

- Use the Russian gateways:
  - `ru.gateway.nekocode.app` (Primary)
  - `ru-2.gateway.nekocode.app` (#2)
  - `ru-3.gateway.nekocode.app` (#3)
- Try each gateway — one may be faster depending on your ISP
- Check gateway status at [status.nekocode.app](https://status.nekocode.app)

---

## 3. Connection Timeout

**Problem:** Requests receive no response, the connection times out.

**Solutions:**

- Check current status at [status.nekocode.app](https://status.nekocode.app)
- Verify your internet connection
- Try a different gateway
- Increase the timeout in your client settings
- Check if there is a firewall or proxy blocking the connection

---

## 4. Invalid API Key

**Problem:** Server returns an authentication error.

**Solutions:**

- Ensure the key starts with the `sk_live_` prefix
- Verify the key in the dashboard: [nekocode.app/dashboard](https://nekocode.app/dashboard)
- Make sure there are no extra spaces or characters in the key
- Generate a new key if the current one may have been compromised
- Verify the key is being passed in the correct header/parameter

---

## 5. Model Not Found

**Problem:** Server returns an error that the specified model does not exist.

**Solutions:**

- Use the exact model ID (e.g., `claude-sonnet-4-6`, not `claude-sonnet`)
- **Codex models** (gpt-5-codex, gpt-5.1-codex, etc.) work **ONLY** via `/v1/responses`. Using `/v1/chat/completions` returns `model_not_found`
- **GPT/Codex models** are available **only on Alpha channel**. Spark returns error
- Check available models in the documentation or dashboard
- Make sure the model is available on the selected channel
- Note that model IDs are case-sensitive

---

## 6. High Latency

**Problem:** Requests succeed but with significant delay.

**Solutions:**

- Use the **Alpha** channel (optimized for speed, x0.3 multiplier)
- Choose the gateway closest to your location:
  - Europe/Global: `gateway.nekocode.app`
  - Russia: `ru.gateway.nekocode.app`, `ru-2.gateway.nekocode.app`, `ru-3.gateway.nekocode.app`
- Reduce `max_tokens` if you don't need long responses
- Check status at [status.nekocode.app](https://status.nekocode.app) — there may be temporary degradation

---

## 7. CORS Errors

**Problem:** Browser blocks API requests due to CORS (Cross-Origin Resource Sharing).

**Solutions:**

- The Nekocode API is intended for **server-side calls only**
- **Do not call the API directly from browser JavaScript**
- Proxy requests through your backend:

```javascript
// DON'T DO THIS (client-side):
// fetch("https://gateway.nekocode.app/alpha/v1/messages", ...)

// DO THIS (through your server):
// Client -> Your Backend -> Nekocode API
```

- Set up a proxy in your server application (Express, FastAPI, etc.)

---

## 8. Claude Code — Extra Usage Required

**Problem:** Claude Code reports "extra usage required" or the context is too large.

**Solutions:**

- Your request context is too large for the current channel
- Switch to the **Spark** channel (x1 multiplier, supports contexts up to [1m] tokens)
- Reduce context by removing unnecessary files from the conversation context
- Use the `/compact` command to compress history
- Check your balance in the dashboard

---

## 9. OpenCode — Provider Not Found

**Problem:** OpenCode throws a "provider not found" error when trying to connect.

**Solutions:**

- Make sure `baseURL` in `opencode.json` ends with the `/v1` suffix:

```json
{
  "provider": {
    "anthropic": {
      "options": {
        "baseURL": "https://gateway.nekocode.app/alpha/v1"
      }
    }
  }
}
```

- Wrong: `https://gateway.nekocode.app/alpha`
- Correct: `https://gateway.nekocode.app/alpha/v1`
- Restart OpenCode after changing the configuration

---

## 10. Codex CLI — Missing API Key

**Problem:** Codex CLI reports that the API key is not found.

**Solutions:**

- Ensure the environment variable name matches the provider:
  - For OpenAI-compatible mode: `OPENAI_API_KEY`
  - For Anthropic-compatible mode: `ANTHROPIC_API_KEY`
- Verify the variables are exported in the current session:

```bash
echo $OPENAI_API_KEY
echo $OPENAI_BASE_URL
```

- If using `config.toml`, make sure `api_key` is set in the correct `[provider]` section
- Restart the terminal after setting environment variables

---

## 11. Codex Models — model_not_found

**Problem:** When requesting Codex models (gpt-5-codex, gpt-5.1-codex, gpt-5.2-codex, gpt-5.3-codex) via `/v1/chat/completions`, server returns `model_not_found`.

**Solutions:**

- Codex models work **ONLY** via OpenAI Responses API: `/v1/responses`
- Use the correct endpoint:

```bash
# WRONG (returns model_not_found):
curl .../v1/chat/completions -d '{"model": "gpt-5.3-codex", ...}'

# CORRECT:
curl .../v1/responses -d '{"model": "gpt-5.3-codex", "max_output_tokens": 4096, "input": "..."}'
```

- `max_output_tokens` for Codex must be **>= 16**, otherwise error
- Codex models available **only on Alpha channel** (not Spark)
- In OpenCode use provider `nekocode-codex` with `@ai-sdk/openai` (not `@ai-sdk/openai-compatible`)

---

## 12. GPT Models Don't Work on Spark

**Problem:** Using GPT or Codex models on Spark channel returns 400/500 error.

**Solution:** Spark supports **only Anthropic Claude models**. Use Alpha channel (`/alpha`) for GPT and Codex.

---

## 13. OpenCode + Codex — "Unknown parameter: reasoningSummary"

**Problem:** When using Codex models (gpt-5-codex, gpt-5.x-codex) through OpenCode, returns error `Unknown parameter: 'reasoningSummary'`.

**Cause:** OpenCode adds `reasoningSummary` and `reasoningEffort` params for GPT-5 models, but via `@ai-sdk/openai-compatible` they are sent as extra fields in Chat Completions API.

**Solution:** Use `@ai-sdk/openai` provider (not `@ai-sdk/openai-compatible`) with `responsesApiSupported: true` and `store: false` options for Codex models:

```json
"nekocode-codex": {
  "npm": "@ai-sdk/openai",
  "options": {
    "apiKey": "sk_live_your_api_key",
    "baseURL": "https://gateway.nekocode.app/alpha/v1"
  },
  "models": {
    "gpt-5.3-codex": {
      "name": "GPT-5.3 Codex",
      "options": { "responsesApiSupported": true, "store": false }
    }
  }
}
```

See [docs/integrations/opencode.md](../integrations/opencode.md) for full config.

---

## 14. GPT-5.1 — "max_tokens reached" with small value

**Problem:** `gpt-5.1` returns 400 with "Could not finish the message because max_tokens or model output limit was reached" when `max_tokens` < ~16.

**Solution:** Set `max_tokens` >= 16 (recommended >= 100). Some models cannot generate a response in just 5 tokens.

---

## General Tips

- Always check [status.nekocode.app](https://status.nekocode.app) before troubleshooting
- Subscribe to @nekocode_status on Telegram for alerts
- For questions, use the Telegram channel [t.me/nekocode_app](https://t.me/nekocode_app)
- API key always starts with `sk_live_`
