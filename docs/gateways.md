# Гейтвеи

> Последнее обновление: 24 марта 2026

Гейтвеи — это точки входа в Nekocode API, расположенные в разных регионах. Выбор гейтвея влияет на задержку (latency) и доступность сервиса из вашего региона.

## Формат URL

```
https://{gateway}/{channel}/v1/messages
```

Где:
- `{gateway}` — домен гейтвея (см. таблицу ниже)
- `{channel}` — канал: `alpha` или `spark`

Пример полного URL:

```
https://ru.gateway.nekocode.app/alpha/v1/messages
```

## Список гейтвеев

| Gateway | Base URL | Регион | Uptime |
|---------|----------|--------|--------|
| **Default (Main)** | `gateway.nekocode.app` | Глобальный (EU/US) | 99.96% |
| **Russia (Primary)** | `ru.gateway.nekocode.app` | Россия | 99.94% |
| **Russia #2** | `ru-2.gateway.nekocode.app` | Россия | 99.99% |
| **Russia #3** | `ru-3.gateway.nekocode.app` | Россия | 99.96% |

## Зачем нужны российские гейтвеи

Nekocode предоставляет три отдельных гейтвея для России по нескольким причинам:

### 1. Обход потенциальных блокировок

Прямой доступ к API Anthropic и OpenAI из России может быть затруднён или невозможен. Российские гейтвеи Nekocode расположены на инфраструктуре, доступной из РФ, и проксируют запросы к провайдерам.

### 2. Низкая задержка для РФ/СНГ

Гейтвей Default оптимизирован для EU/US. Для пользователей из России и стран СНГ российские гейтвеи обеспечивают значительно меньшую задержку (latency), что критично при работе с AI-ассистентами в реальном времени.

### 3. Три сервера для надёжности

Три резервных российских сервера (`ru`, `ru-2`, `ru-3`) обеспечивают отказоустойчивость:

- Если `ru.gateway.nekocode.app` недоступен — переключайся на `ru-2.gateway.nekocode.app`
- Если `ru-2` тоже недоступен — используй `ru-3.gateway.nekocode.app`
- Актуальный статус всех гейтвеев: [status.nekocode.app](https://status.nekocode.app)

## Какой гейтвей выбрать

```
Ты в России/СНГ?
├── Да → ru.gateway.nekocode.app (основной)
│         ├── Не работает? → ru-2.gateway.nekocode.app
│         └── Тоже не работает? → ru-3.gateway.nekocode.app
└── Нет → gateway.nekocode.app (глобальный)
```

**Правило простое:** если ты в РФ — начинай с `ru`, если за пределами — используй `gateway`.

## Примеры полных URL

### Default gateway + Alpha канал

```
https://gateway.nekocode.app/alpha/v1/messages
```

### Russian gateway + Alpha канал

```
https://ru.gateway.nekocode.app/alpha/v1/messages
```

### Russian #2 gateway + Spark канал

```
https://ru-2.gateway.nekocode.app/spark/v1/messages
```

### Russian #3 gateway + Spark канал

```
https://ru-3.gateway.nekocode.app/spark/v1/messages
```

## Переключение между гейтвеями

Переключение гейтвея — это замена доменной части URL. API-ключ и остальные параметры запроса остаются без изменений.

```bash
# Было (Default):
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/alpha"

# Стало (Russia):
export ANTHROPIC_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

Для инструментов, использующих конфигурационные файлы (Claude Code, OpenCode, и т.д.), достаточно изменить `baseURL` в настройках. Подробнее: [switching.md](switching.md)

## Мониторинг

Актуальный статус всех гейтвеев доступен на:

- **Status page:** [status.nekocode.app](https://status.nekocode.app)
- **Telegram:** [@nekocode_status](https://t.me/nekocode_status) (алерты в реальном времени)
- **Dashboard:** [nekocode.app/dashboard](https://nekocode.app/dashboard) (персональная статистика)

Подробнее: [status.md](status.md)

---

# Gateways

> Last updated: March 24, 2026

Gateways are entry points to the Nekocode API located in different regions. Your gateway choice affects latency and service availability from your region.

## URL Format

```
https://{gateway}/{channel}/v1/messages
```

Where:
- `{gateway}` — gateway domain (see table below)
- `{channel}` — channel: `alpha` or `spark`

Full URL example:

```
https://ru.gateway.nekocode.app/alpha/v1/messages
```

## Gateway List

| Gateway | Base URL | Region | Uptime |
|---------|----------|--------|--------|
| **Default (Main)** | `gateway.nekocode.app` | Global (EU/US) | 99.96% |
| **Russia (Primary)** | `ru.gateway.nekocode.app` | Russia | 99.94% |
| **Russia #2** | `ru-2.gateway.nekocode.app` | Russia | 99.99% |
| **Russia #3** | `ru-3.gateway.nekocode.app` | Russia | 99.96% |

## Why Russian Gateways Exist

Nekocode provides three separate gateways for Russia for several reasons:

### 1. Bypassing Potential Blocks

Direct access to Anthropic and OpenAI APIs from Russia may be difficult or impossible. Nekocode's Russian gateways are hosted on infrastructure accessible from Russia and proxy requests to the providers.

### 2. Lower Latency for Russia/CIS

The Default gateway is optimized for EU/US. For users in Russia and CIS countries, Russian gateways provide significantly lower latency, which is critical when working with AI assistants in real time.

### 3. Three Servers for Reliability

Three redundant Russian servers (`ru`, `ru-2`, `ru-3`) ensure fault tolerance:

- If `ru.gateway.nekocode.app` is down — switch to `ru-2.gateway.nekocode.app`
- If `ru-2` is also down — use `ru-3.gateway.nekocode.app`
- Current status of all gateways: [status.nekocode.app](https://status.nekocode.app)

## Which Gateway to Choose

```
Are you in Russia/CIS?
├── Yes → ru.gateway.nekocode.app (primary)
│          ├── Down? → ru-2.gateway.nekocode.app
│          └── Also down? → ru-3.gateway.nekocode.app
└── No → gateway.nekocode.app (global)
```

**Simple rule:** if you're in Russia — start with `ru`, if outside — use `gateway`.

## Full URL Examples

### Default gateway + Alpha channel

```
https://gateway.nekocode.app/alpha/v1/messages
```

### Russian gateway + Alpha channel

```
https://ru.gateway.nekocode.app/alpha/v1/messages
```

### Russian #2 gateway + Spark channel

```
https://ru-2.gateway.nekocode.app/spark/v1/messages
```

### Russian #3 gateway + Spark channel

```
https://ru-3.gateway.nekocode.app/spark/v1/messages
```

## Switching Between Gateways

Switching gateways means replacing the domain part of the URL. The API key and other request parameters remain unchanged.

```bash
# Before (Default):
export ANTHROPIC_BASE_URL="https://gateway.nekocode.app/alpha"

# After (Russia):
export ANTHROPIC_BASE_URL="https://ru.gateway.nekocode.app/alpha"
```

For tools using configuration files (Claude Code, OpenCode, etc.), just change the `baseURL` in settings. Details: [switching.md](switching.md)

## Monitoring

Current status of all gateways is available at:

- **Status page:** [status.nekocode.app](https://status.nekocode.app)
- **Telegram:** [@nekocode_status](https://t.me/nekocode_status) (real-time alerts)
- **Dashboard:** [nekocode.app/dashboard](https://nekocode.app/dashboard) (personal statistics)

Details: [status.md](status.md)
