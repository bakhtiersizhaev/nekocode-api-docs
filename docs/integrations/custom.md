# Кастомная интеграция

> Дата обновления: 24 марта 2026

## Обзор

Руководство по интеграции Nekocode в ваши собственные проекты: веб-приложения, боты, мобильные приложения, серверлесс-функции и другие сценарии.

## Базовые URL

| Шлюз      | Anthropic API                             | OpenAI-совместимый API                        |
|-----------|-------------------------------------------|-----------------------------------------------|
| Основной  | `https://gateway.nekocode.app/{channel}`  | `https://gateway.nekocode.app/{channel}/v1`   |
| Россия    | `https://ru.gateway.nekocode.app/{channel}` | `https://ru.gateway.nekocode.app/{channel}/v1` |

Каналы: `alpha`, `spark`

---

## 1. Веб-приложения

### Node.js / Express

```javascript
import express from 'express';
import Anthropic from '@anthropic-ai/sdk';

const app = express();
app.use(express.json());

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

app.post('/api/chat', async (req, res) => {
  const { message } = req.body;

  const response = await client.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: message }],
  });

  res.json({ reply: response.content[0].text });
});

app.listen(3000);
```

### Next.js API Route

```typescript
// app/api/chat/route.ts
import Anthropic from '@anthropic-ai/sdk';
import { NextRequest, NextResponse } from 'next/server';

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

export async function POST(req: NextRequest) {
  const { message } = await req.json();

  const response = await client.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: message }],
  });

  return NextResponse.json({ reply: response.content[0].text });
}
```

### Python / FastAPI

```python
from fastapi import FastAPI
from pydantic import BaseModel
import anthropic

app = FastAPI()
client = anthropic.Anthropic(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha"
)

class ChatRequest(BaseModel):
    message: str

@app.post("/api/chat")
async def chat(req: ChatRequest):
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": req.message}]
    )
    return {"reply": response.content[0].text}
```

### Python / Django

```python
# views.py
import json
import anthropic
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

client = anthropic.Anthropic(
    api_key=settings.NEKOCODE_API_KEY,
    base_url="https://gateway.nekocode.app/alpha"
)

@csrf_exempt
def chat_view(request):
    if request.method == "POST":
        data = json.loads(request.body)
        response = client.messages.create(
            model="claude-sonnet-4-6",
            max_tokens=1024,
            messages=[{"role": "user", "content": data["message"]}]
        )
        return JsonResponse({"reply": response.content[0].text})
```

---

## 2. Telegram-боты

### python-telegram-bot + Anthropic SDK

```python
import anthropic
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

TELEGRAM_TOKEN = "your_telegram_bot_token"
NEKOCODE_KEY = "sk_live_your_api_key"

ai_client = anthropic.Anthropic(
    api_key=NEKOCODE_KEY,
    base_url="https://gateway.nekocode.app/alpha"
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Привет! Я бот с AI от Nekocode. Напиши мне что-нибудь!"
    )

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_message = update.message.text

    response = ai_client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": user_message}]
    )

    await update.message.reply_text(response.content[0].text)

def main():
    app = Application.builder().token(TELEGRAM_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
    app.run_polling()

if __name__ == "__main__":
    main()
```

### Telegraf (Node.js) + Anthropic SDK

```typescript
import { Telegraf } from 'telegraf';
import Anthropic from '@anthropic-ai/sdk';

const bot = new Telegraf(process.env.TELEGRAM_TOKEN!);
const ai = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

bot.start((ctx) => ctx.reply('Привет! Напиши мне что-нибудь.'));

bot.on('text', async (ctx) => {
  const response = await ai.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: ctx.message.text }],
  });

  await ctx.reply(response.content[0].text);
});

bot.launch();
```

---

## 3. Discord-боты

### discord.js + Nekocode API

```typescript
import { Client, GatewayIntentBits } from 'discord.js';
import Anthropic from '@anthropic-ai/sdk';

const discord = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

const ai = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

discord.on('messageCreate', async (message) => {
  if (message.author.bot) return;
  if (!message.content.startsWith('!ask ')) return;

  const query = message.content.slice(5);

  const response = await ai.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: query }],
  });

  await message.reply(response.content[0].text);
});

discord.login(process.env.DISCORD_TOKEN);
```

---

## 4. Мобильные приложения

> **ВАЖНО**: Никогда не размещайте API-ключ в клиентском коде мобильного приложения. Всегда проксируйте запросы через ваш бэкенд.

### React Native

```typescript
// Бэкенд (Express) — см. раздел "Веб-приложения" выше
// Клиент React Native:
const sendMessage = async (text: string) => {
  const res = await fetch('https://your-backend.com/api/chat', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message: text }),
  });
  const data = await res.json();
  return data.reply;
};
```

### Flutter

```dart
// Клиент Flutter — запрос к вашему бэкенду:
Future<String> sendMessage(String text) async {
  final response = await http.post(
    Uri.parse('https://your-backend.com/api/chat'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'message': text}),
  );
  final data = jsonDecode(response.body);
  return data['reply'];
}
```

---

## 5. Серверлесс-функции

### Vercel Edge Function

```typescript
// api/chat.ts
export const config = { runtime: 'edge' };

export default async function handler(req: Request) {
  const { message } = await req.json();

  const response = await fetch('https://gateway.nekocode.app/alpha/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': process.env.NEKOCODE_API_KEY!,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: 'claude-sonnet-4-6',
      max_tokens: 1024,
      messages: [{ role: 'user', content: message }],
    }),
  });

  return new Response(response.body, {
    headers: { 'Content-Type': 'application/json' },
  });
}
```

### Cloudflare Worker

```typescript
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const { message } = await request.json();

    const response = await fetch('https://gateway.nekocode.app/alpha/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': env.NEKOCODE_API_KEY,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-6',
        max_tokens: 1024,
        messages: [{ role: 'user', content: message }],
      }),
    });

    return new Response(response.body, {
      headers: { 'Content-Type': 'application/json' },
    });
  },
};
```

---

## 6. OpenAI-совместимый режим

Для GPT-моделей используйте OpenAI SDK с URL Nekocode:

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
```

Любая библиотека или инструмент, поддерживающий OpenAI API, будет работать с Nekocode — достаточно указать `base_url`.

---

## 7. REST API (любой язык)

### Эндпоинты

| Протокол  | Метод | Эндпоинт                     | Описание                 |
|-----------|-------|-------------------------------|--------------------------|
| Anthropic | POST  | `/v1/messages`                | Создание сообщения       |
| OpenAI    | POST  | `/v1/chat/completions`        | Чат-комплишн             |

### Аутентификация

| API       | Заголовок                                    |
|-----------|----------------------------------------------|
| Anthropic | `x-api-key: sk_live_your_api_key`            |
| OpenAI    | `Authorization: Bearer sk_live_your_api_key` |

### Пример на Go

```go
package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "io"
    "net/http"
)

func main() {
    body, _ := json.Marshal(map[string]interface{}{
        "model":      "claude-sonnet-4-6",
        "max_tokens": 1024,
        "messages":   []map[string]string{{"role": "user", "content": "Hello!"}},
    })

    req, _ := http.NewRequest("POST",
        "https://gateway.nekocode.app/alpha/v1/messages", bytes.NewBuffer(body))
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("x-api-key", "sk_live_your_api_key")
    req.Header.Set("anthropic-version", "2023-06-01")

    resp, _ := http.DefaultClient.Do(req)
    defer resp.Body.Close()
    data, _ := io.ReadAll(resp.Body)
    fmt.Println(string(data))
}
```

---

## 8. Безопасность

### Обязательные правила

- **Никогда** не размещайте API-ключ в клиентском коде (фронтенд, мобильное приложение)
- Используйте переменные окружения (`NEKOCODE_API_KEY`) для хранения ключа
- Проксируйте все запросы через ваш бэкенд
- Настройте rate limiting на вашей стороне, чтобы защитить ключ от злоупотреблений
- Логируйте запросы для мониторинга использования

### Пример .env

```bash
NEKOCODE_API_KEY=sk_live_your_api_key
NEKOCODE_BASE_URL=https://gateway.nekocode.app/alpha
```

### Пример загрузки в Node.js

```typescript
import 'dotenv/config';

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: process.env.NEKOCODE_BASE_URL!,
});
```

### Пример загрузки в Python

```python
import os
from dotenv import load_dotenv
import anthropic

load_dotenv()

client = anthropic.Anthropic(
    api_key=os.environ["NEKOCODE_API_KEY"],
    base_url=os.environ["NEKOCODE_BASE_URL"]
)
```

---

---

# Custom Integration

> Updated: March 24, 2026

## Overview

A guide for integrating Nekocode into your own projects: web apps, bots, mobile apps, serverless functions, and other scenarios.

## Base URLs

| Gateway  | Anthropic API                             | OpenAI-compatible API                         |
|----------|-------------------------------------------|-----------------------------------------------|
| Default  | `https://gateway.nekocode.app/{channel}`  | `https://gateway.nekocode.app/{channel}/v1`   |
| Russia   | `https://ru.gateway.nekocode.app/{channel}` | `https://ru.gateway.nekocode.app/{channel}/v1` |

Channels: `alpha`, `spark`

---

## 1. Web Applications

### Node.js / Express

```javascript
import express from 'express';
import Anthropic from '@anthropic-ai/sdk';

const app = express();
app.use(express.json());

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

app.post('/api/chat', async (req, res) => {
  const { message } = req.body;

  const response = await client.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: message }],
  });

  res.json({ reply: response.content[0].text });
});

app.listen(3000);
```

### Next.js API Route

```typescript
// app/api/chat/route.ts
import Anthropic from '@anthropic-ai/sdk';
import { NextRequest, NextResponse } from 'next/server';

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

export async function POST(req: NextRequest) {
  const { message } = await req.json();

  const response = await client.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: message }],
  });

  return NextResponse.json({ reply: response.content[0].text });
}
```

### Python / FastAPI

```python
from fastapi import FastAPI
from pydantic import BaseModel
import anthropic

app = FastAPI()
client = anthropic.Anthropic(
    api_key="sk_live_your_api_key",
    base_url="https://gateway.nekocode.app/alpha"
)

class ChatRequest(BaseModel):
    message: str

@app.post("/api/chat")
async def chat(req: ChatRequest):
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": req.message}]
    )
    return {"reply": response.content[0].text}
```

### Python / Django

```python
# views.py
import json
import anthropic
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings

client = anthropic.Anthropic(
    api_key=settings.NEKOCODE_API_KEY,
    base_url="https://gateway.nekocode.app/alpha"
)

@csrf_exempt
def chat_view(request):
    if request.method == "POST":
        data = json.loads(request.body)
        response = client.messages.create(
            model="claude-sonnet-4-6",
            max_tokens=1024,
            messages=[{"role": "user", "content": data["message"]}]
        )
        return JsonResponse({"reply": response.content[0].text})
```

---

## 2. Telegram Bots

### python-telegram-bot + Anthropic SDK

```python
import anthropic
from telegram import Update
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

TELEGRAM_TOKEN = "your_telegram_bot_token"
NEKOCODE_KEY = "sk_live_your_api_key"

ai_client = anthropic.Anthropic(
    api_key=NEKOCODE_KEY,
    base_url="https://gateway.nekocode.app/alpha"
)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "Hi! I'm an AI bot powered by Nekocode. Send me a message!"
    )

async def handle_message(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_message = update.message.text

    response = ai_client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=[{"role": "user", "content": user_message}]
    )

    await update.message.reply_text(response.content[0].text)

def main():
    app = Application.builder().token(TELEGRAM_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
    app.run_polling()

if __name__ == "__main__":
    main()
```

### Telegraf (Node.js) + Anthropic SDK

```typescript
import { Telegraf } from 'telegraf';
import Anthropic from '@anthropic-ai/sdk';

const bot = new Telegraf(process.env.TELEGRAM_TOKEN!);
const ai = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

bot.start((ctx) => ctx.reply('Hi! Send me a message.'));

bot.on('text', async (ctx) => {
  const response = await ai.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: ctx.message.text }],
  });

  await ctx.reply(response.content[0].text);
});

bot.launch();
```

---

## 3. Discord Bots

### discord.js + Nekocode API

```typescript
import { Client, GatewayIntentBits } from 'discord.js';
import Anthropic from '@anthropic-ai/sdk';

const discord = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
});

const ai = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: 'https://gateway.nekocode.app/alpha',
});

discord.on('messageCreate', async (message) => {
  if (message.author.bot) return;
  if (!message.content.startsWith('!ask ')) return;

  const query = message.content.slice(5);

  const response = await ai.messages.create({
    model: 'claude-sonnet-4-6',
    max_tokens: 1024,
    messages: [{ role: 'user', content: query }],
  });

  await message.reply(response.content[0].text);
});

discord.login(process.env.DISCORD_TOKEN);
```

---

## 4. Mobile Apps

> **IMPORTANT**: Never put the API key in client-side mobile app code. Always proxy requests through your backend.

### React Native

```typescript
// Backend (Express) — see "Web Applications" section above
// React Native client:
const sendMessage = async (text: string) => {
  const res = await fetch('https://your-backend.com/api/chat', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message: text }),
  });
  const data = await res.json();
  return data.reply;
};
```

### Flutter

```dart
// Flutter client — request to your backend:
Future<String> sendMessage(String text) async {
  final response = await http.post(
    Uri.parse('https://your-backend.com/api/chat'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'message': text}),
  );
  final data = jsonDecode(response.body);
  return data['reply'];
}
```

---

## 5. Serverless Functions

### Vercel Edge Function

```typescript
// api/chat.ts
export const config = { runtime: 'edge' };

export default async function handler(req: Request) {
  const { message } = await req.json();

  const response = await fetch('https://gateway.nekocode.app/alpha/v1/messages', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-api-key': process.env.NEKOCODE_API_KEY!,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: 'claude-sonnet-4-6',
      max_tokens: 1024,
      messages: [{ role: 'user', content: message }],
    }),
  });

  return new Response(response.body, {
    headers: { 'Content-Type': 'application/json' },
  });
}
```

### Cloudflare Worker

```typescript
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const { message } = await request.json();

    const response = await fetch('https://gateway.nekocode.app/alpha/v1/messages', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': env.NEKOCODE_API_KEY,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model: 'claude-sonnet-4-6',
        max_tokens: 1024,
        messages: [{ role: 'user', content: message }],
      }),
    });

    return new Response(response.body, {
      headers: { 'Content-Type': 'application/json' },
    });
  },
};
```

---

## 6. OpenAI Compatibility Mode

For GPT models, use the OpenAI SDK with the Nekocode URL:

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
```

Any library or tool that supports the OpenAI API will work with Nekocode — just set the `base_url`.

---

## 7. REST API (Any Language)

### Endpoints

| Protocol  | Method | Endpoint                      | Description            |
|-----------|--------|-------------------------------|------------------------|
| Anthropic | POST   | `/v1/messages`                | Create a message       |
| OpenAI    | POST   | `/v1/chat/completions`        | Chat completion        |

### Authentication

| API       | Header                                       |
|-----------|----------------------------------------------|
| Anthropic | `x-api-key: sk_live_your_api_key`            |
| OpenAI    | `Authorization: Bearer sk_live_your_api_key` |

### Go Example

```go
package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "io"
    "net/http"
)

func main() {
    body, _ := json.Marshal(map[string]interface{}{
        "model":      "claude-sonnet-4-6",
        "max_tokens": 1024,
        "messages":   []map[string]string{{"role": "user", "content": "Hello!"}},
    })

    req, _ := http.NewRequest("POST",
        "https://gateway.nekocode.app/alpha/v1/messages", bytes.NewBuffer(body))
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("x-api-key", "sk_live_your_api_key")
    req.Header.Set("anthropic-version", "2023-06-01")

    resp, _ := http.DefaultClient.Do(req)
    defer resp.Body.Close()
    data, _ := io.ReadAll(resp.Body)
    fmt.Println(string(data))
}
```

---

## 8. Security

### Mandatory Rules

- **Never** put the API key in client-side code (frontend, mobile app)
- Use environment variables (`NEKOCODE_API_KEY`) to store the key
- Proxy all requests through your backend
- Set up rate limiting on your side to protect the key from abuse
- Log requests for usage monitoring

### Example .env

```bash
NEKOCODE_API_KEY=sk_live_your_api_key
NEKOCODE_BASE_URL=https://gateway.nekocode.app/alpha
```

### Loading in Node.js

```typescript
import 'dotenv/config';

const client = new Anthropic({
  apiKey: process.env.NEKOCODE_API_KEY!,
  baseURL: process.env.NEKOCODE_BASE_URL!,
});
```

### Loading in Python

```python
import os
from dotenv import load_dotenv
import anthropic

load_dotenv()

client = anthropic.Anthropic(
    api_key=os.environ["NEKOCODE_API_KEY"],
    base_url=os.environ["NEKOCODE_BASE_URL"]
)
```
