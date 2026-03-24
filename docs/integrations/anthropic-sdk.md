# Anthropic SDK (Python & TypeScript)

> Дата обновления: 24 марта 2026

## Обзор

Официальные SDK Anthropic для Python и TypeScript/Node.js поддерживают параметр `base_url` / `baseURL`, что позволяет направить запросы через шлюз Nekocode без изменения логики приложения.

## Python

### Установка

```bash
pip install anthropic
```

### Использование

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha"
)

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)

print(message.content[0].text)
```

### Стриминг (Python)

```python
with client.messages.stream(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Расскажи о квантовых вычислениях"}]
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

## TypeScript / Node.js

### Установка

```bash
npm install @anthropic-ai/sdk
```

### Использование

```typescript
import Anthropic from '@anthropic-ai/sdk';

const client = new Anthropic({
  apiKey: 'sk_live_your_api_key',
  baseURL: 'https://gateway.nekocode.app/alpha',
});

const message = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }],
});

console.log(message.content[0].text);
```

### Стриминг (TypeScript)

```typescript
const stream = client.messages.stream({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }],
});

for await (const event of stream) {
  if (event.type === 'content_block_delta' && event.delta.type === 'text_delta') {
    process.stdout.write(event.delta.text);
  }
}
```

## OpenAI SDK (для GPT-моделей через Nekocode)

Nekocode поддерживает OpenAI-совместимый эндпоинт. Для работы с GPT-моделями используйте OpenAI SDK с `/v1` в URL.

### Python

```python
from openai import OpenAI

client = OpenAI(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha/v1"
)

response = client.chat.completions.create(
    model="gpt-5",
    messages=[{"role": "user", "content": "Hello!"}]
)

print(response.choices[0].message.content)
```

### TypeScript

```typescript
import OpenAI from 'openai';

const client = new OpenAI({
  apiKey: 'sk_live_your_api_key',
  baseURL: 'https://gateway.nekocode.app/alpha/v1',
});

const response = await client.chat.completions.create({
  model: 'gpt-5',
  messages: [{ role: 'user', content: 'Hello!' }],
});

console.log(response.choices[0].message.content);
```

## Шлюз для России

Замените base URL на:

| SDK        | Параметр   | Значение                                  |
|------------|------------|-------------------------------------------|
| Anthropic  | `base_url` | `https://ru.gateway.nekocode.app/alpha`   |
| OpenAI     | `base_url` | `https://ru.gateway.nekocode.app/alpha/v1`|

## Доступные каналы

| Канал | Anthropic base_url                        | OpenAI base_url                               |
|-------|-------------------------------------------|-----------------------------------------------|
| alpha | `https://gateway.nekocode.app/alpha`      | `https://gateway.nekocode.app/alpha/v1`       |
| spark | `https://gateway.nekocode.app/spark`      | `https://gateway.nekocode.app/spark/v1`       |

## Откат к стандартным настройкам

Чтобы вернуться к прямому подключению:

- **Anthropic SDK**: удалите параметр `base_url` / `baseURL` — SDK автоматически будет использовать `https://api.anthropic.com`
- **OpenAI SDK**: удалите параметр `base_url` / `baseURL` — SDK автоматически будет использовать `https://api.openai.com/v1`
- Замените API-ключ Nekocode на ваш стандартный ключ провайдера

---

# Anthropic SDK (Python & TypeScript)

> Updated: March 24, 2026

## Overview

The official Anthropic SDKs for Python and TypeScript/Node.js support a `base_url` / `baseURL` parameter, allowing you to route requests through the Nekocode gateway without changing your application logic.

## Python

### Installation

```bash
pip install anthropic
```

### Usage

```python
import anthropic

client = anthropic.Anthropic(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha"
)

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello!"}]
)

print(message.content[0].text)
```

### Streaming (Python)

```python
with client.messages.stream(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Tell me about quantum computing"}]
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

## TypeScript / Node.js

### Installation

```bash
npm install @anthropic-ai/sdk
```

### Usage

```typescript
import Anthropic from '@anthropic-ai/sdk';

const client = new Anthropic({
  apiKey: 'sk_live_your_api_key',
  baseURL: 'https://gateway.nekocode.app/alpha',
});

const message = await client.messages.create({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }],
});

console.log(message.content[0].text);
```

### Streaming (TypeScript)

```typescript
const stream = client.messages.stream({
  model: 'claude-sonnet-4-6',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello!' }],
});

for await (const event of stream) {
  if (event.type === 'content_block_delta' && event.delta.type === 'text_delta') {
    process.stdout.write(event.delta.text);
  }
}
```

## OpenAI SDK (for GPT Models via Nekocode)

Nekocode supports an OpenAI-compatible endpoint. To use GPT models, use the OpenAI SDK with `/v1` appended to the URL.

### Python

```python
from openai import OpenAI

client = OpenAI(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha/v1"
)

response = client.chat.completions.create(
    model="gpt-5",
    messages=[{"role": "user", "content": "Hello!"}]
)

print(response.choices[0].message.content)
```

### TypeScript

```typescript
import OpenAI from 'openai';

const client = new OpenAI({
  apiKey: 'sk_live_your_api_key',
  baseURL: 'https://gateway.nekocode.app/alpha/v1',
});

const response = await client.chat.completions.create({
  model: 'gpt-5',
  messages: [{ role: 'user', content: 'Hello!' }],
});

console.log(response.choices[0].message.content);
```

## Russia Gateway

Change the base URL to:

| SDK        | Parameter  | Value                                     |
|------------|------------|-------------------------------------------|
| Anthropic  | `base_url` | `https://ru.gateway.nekocode.app/alpha`   |
| OpenAI     | `base_url` | `https://ru.gateway.nekocode.app/alpha/v1`|

## Available Channels

| Channel | Anthropic base_url                        | OpenAI base_url                               |
|---------|-------------------------------------------|-----------------------------------------------|
| alpha   | `https://gateway.nekocode.app/alpha`      | `https://gateway.nekocode.app/alpha/v1`       |
| spark   | `https://gateway.nekocode.app/spark`      | `https://gateway.nekocode.app/spark/v1`       |

## Reverting to Default Settings

To revert to direct provider connections:

- **Anthropic SDK**: remove the `base_url` / `baseURL` parameter — the SDK will default to `https://api.anthropic.com`
- **OpenAI SDK**: remove the `base_url` / `baseURL` parameter — the SDK will default to `https://api.openai.com/v1`
- Replace your Nekocode API key with your standard provider key
