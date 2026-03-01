# OpenClaw Quickstart 🦞

One-command setup for OpenClaw on **WSL**, **Linux**, or **VPS**.

---

## 🚀 Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
```

**That's it.** The script handles everything — Node.js, OpenClaw, config, optional trading skill.

**Time:** ~5 minutes | **Requirements:** 4GB RAM, 2GB disk, internet

---

## 📋 Before You Start

### Get an API Key (2 min)

| Provider | Cost | Best For | Link |
|----------|------|----------|------|
| **Anthropic** ⭐ | ~$5-15/mo | Best quality | [console.anthropic.com](https://console.anthropic.com/) |
| **OpenRouter** | $0+ | Budget/free models | [openrouter.ai](https://openrouter.ai/) |
| **Google AI** | Free tier | Getting started | [aistudio.google.com](https://aistudio.google.com/) |
| **Ollama** | Free (local) | Privacy, no API | [ollama.com](https://ollama.com/) |

<details>
<summary><b>📖 Detailed setup for each provider</b></summary>

#### Anthropic (Recommended)
1. Sign up at [console.anthropic.com](https://console.anthropic.com/)
2. Go to **API Keys** → **Create Key**
3. Copy key (starts with `sk-ant-`)
4. Use model: `claude-sonnet-4-20250514`

#### OpenRouter (Budget)
1. Sign up at [openrouter.ai](https://openrouter.ai/)
2. Go to **Keys** → **Create Key**
3. Copy key (starts with `sk-or-`)
4. Free models: `meta-llama/llama-3-70b-instruct`, `mistralai/mistral-7b-instruct`

#### Google AI (Free)
1. Go to [aistudio.google.com](https://aistudio.google.com/)
2. Click **Get API Key** → **Create API key**
3. Use model: `gemini-1.5-flash`
4. Limits: 60 req/min, 1M tokens/day free

#### Ollama (Local)
```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3:8b
```
No API key needed — runs on your hardware.

</details>

### Windows Users: Install WSL First

<details>
<summary><b>📖 WSL setup (3 min)</b></summary>

1. Open **PowerShell as Administrator**
2. Run: `wsl --install`
3. **Restart your computer**
4. Ubuntu opens → create username + password
5. You're ready — run the Quick Install command above

</details>

---

## ✅ After Installation

```bash
openclaw gateway         # Start OpenClaw
openclaw health          # Check status
openclaw channels login discord    # Connect Discord (optional)
openclaw channels login whatsapp   # Connect WhatsApp (optional)
```

---

## 🤖 Model Guide

<details>
<summary><b>Which model should I use?</b></summary>

| Model | Monthly Cost | Capability | Use Case |
|-------|--------------|------------|----------|
| **Claude Sonnet** | ~$5-15 | ✅ Great | Daily tasks, coding — best value |
| **Claude Opus** | ~$30-50 | ✅✅ Best | Complex reasoning, autonomous work |
| **GPT-4o** | ~$10-20 | ✅ Great | Vision, multimodal tasks |
| **Gemini Flash** | Free | ⚠️ Good | Budget, simple tasks |
| **Llama 70B** | Free (local) | ⚠️ Decent | Privacy, offline use |
| **Llama 8B** | Free (local) | ❌ Basic | Chat only, runs on any PC |

**TL;DR:** Start with **Claude Sonnet**. Upgrade to Opus if you need complex multi-step automation.

</details>

<details>
<summary><b>What can each model actually do?</b></summary>

| Capability | Opus | Sonnet/GPT-4o | Llama 70B | Small (7-8B) |
|------------|------|---------------|-----------|--------------|
| Chat & Q&A | ✅ | ✅ | ✅ | ✅ |
| Code generation | ✅ | ✅ | ⚠️ | ⚠️ |
| Multi-step automation | ✅ | ✅ | ⚠️ | ❌ |
| Tool use (APIs, files) | ✅ | ✅ | ⚠️ | ❌ |
| Complex reasoning | ✅ | ⚠️ | ⚠️ | ❌ |
| Trading/financial | ✅ | ✅ | ❌ | ❌ |

</details>

<details>
<summary><b>💰 Budget setups (get 80% capability for 20% cost)</b></summary>

**$10/mo — "Good Enough"**
- Claude Sonnet for everything
- Handles 80% of what Opus does

**$0 — "Free Tier Warrior"**
- Gemini Flash (free tier) + OpenRouter free models
- Rate limits, less reliable, but costs nothing

**$0 — "Local First"**
- Ollama + Llama 3 (8B runs on any PC, 70B needs 32GB+ RAM)
- Complete privacy, unlimited use

**$5-10/mo — "Hybrid"**
- Local Llama for chat, Cloud Sonnet for tools
- Best of both worlds

</details>

---

## ⚠️ Risks & Security

<details>
<summary><b>What are the risks?</b></summary>

| Risk | Severity | Mitigation |
|------|----------|------------|
| AI reads sensitive files | Medium | Restrict paths in config |
| AI runs bad commands | High | Use allowlist, dedicated user |
| API cost overruns | Medium | Set spending limits |
| Data exfiltration | Low | Monitor network, use local |

**Key principle:** The AI has exactly as much access as you give it.

</details>

<details>
<summary><b>🔒 Sandboxing options</b></summary>

**Most isolated → Least isolated:**

1. **Docker container** — Can't touch your files
   ```bash
   docker run -it --name openclaw ubuntu:22.04 bash
   # Run setup inside container
   ```

2. **Dedicated VPS** ($5-10/mo) — Complete separation
   - [Hostinger](https://hostinger.com) ⭐ | [DigitalOcean](https://digitalocean.com) | [Linode](https://linode.com)

3. **Dedicated WSL instance** (Windows)
   ```powershell
   wsl --install -d Debian
   ```

4. **Dedicated user account**
   ```bash
   sudo adduser openclaw-user
   sudo su - openclaw-user
   # Run setup as this user
   ```

5. **Default install** — Full access (for power users)

</details>

---

## 🔧 Troubleshooting

| Problem | Fix |
|---------|-----|
| `openclaw: command not found` | Run `source ~/.bashrc` |
| Permission denied | Use `bash -c "$(curl ...)"` |
| WSL won't start | Run `wsl --shutdown` in PowerShell |
| Something else | Run `openclaw doctor` |

---

## 📁 Files & Help

| What | Where |
|------|-------|
| Config | `~/.openclaw/openclaw.json` |
| Workspace | `~/.openclaw/workspace/` |
| Logs | `/tmp/openclaw/` |

**Help:** [docs.openclaw.ai](https://docs.openclaw.ai) • [Discord](https://discord.com/invite/clawd) • [GitHub](https://github.com/openclaw/openclaw)

---

MIT License • Made with ☀️ by [Sol](https://github.com/stevenartzt/Sol)
