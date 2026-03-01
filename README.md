# OpenClaw Quickstart 🦞

One-command setup for OpenClaw on **WSL**, **Linux**, or **VPS**.

> ℹ️ **What's included:** This installer sets up OpenClaw and optionally includes the [Public.com trading skill](https://github.com/publicdotcom/claw-skill-public-dot-com) for stock/options trading via the Public.com API. You'll be asked during setup if you want to install it — it's completely optional.

---

## 📋 Before You Start

You'll need:

| ✅ | Requirement | How to Get It |
|----|-------------|---------------|
| ☐ | **Windows 10/11** OR **Linux** OR **Mac** | You probably have this already |
| ☐ | **4GB+ RAM** | Check: Settings → System → About |
| ☐ | **2GB free disk space** | Check: File Explorer → This PC |
| ☐ | **Internet connection** | You're reading this, so ✓ |
| ☐ | **AI API Key** | Get one below (takes 2 min) |

### 🔑 Get Your API Key (Required)

Pick ONE provider and sign up:

| Provider | Link | Free Tier? |
|----------|------|------------|
| **Anthropic** (Recommended) | [console.anthropic.com](https://console.anthropic.com/) | $5 free credit |
| **OpenAI** | [platform.openai.com](https://platform.openai.com/) | Pay as you go |
| **OpenRouter** | [openrouter.ai](https://openrouter.ai/) | Some free models |

**Save your API key somewhere safe** — you'll paste it during setup.

### 🤖 Model Comparison

| Model | Best For | Pros | Cons | Cost |
|-------|----------|------|------|------|
| **Claude Sonnet 3.5** | Daily tasks, coding, chat | Fast, cheap, great at code | Less capable than Opus | ~$3/M tokens |
| **Claude Opus 4** | Complex reasoning, long tasks | Most capable Claude, deep thinking | Expensive, slower | ~$15/M tokens |
| **GPT-4o** | Multimodal, vision tasks | Fast, good vision, large context | Can be verbose | ~$5/M tokens |
| **GPT-4 Turbo** | General use | Good all-rounder | Being phased out | ~$10/M tokens |
| **Gemini Pro** | Google ecosystem | Free tier, fast | Less consistent | Free - $3.50/M |
| **Llama 3 70B** | Privacy, local hosting | Can run locally, no API needed | Requires powerful hardware | Free (local) |

### What's Actually Possible With Each Model?

| Capability | Claude Opus | Sonnet/GPT-4o | Llama 70B Local | Small Models (7B) |
|------------|-------------|---------------|-----------------|-------------------|
| **Simple chat & Q&A** | ✅ Overkill | ✅ Great | ✅ Good | ✅ Fine |
| **Code generation** | ✅ Excellent | ✅ Great | ⚠️ Decent | ⚠️ Basic only |
| **Multi-step automation** | ✅ Reliable | ✅ Usually works | ⚠️ Hit or miss | ❌ Struggles |
| **Tool use (APIs, files)** | ✅ Excellent | ✅ Good | ⚠️ Inconsistent | ❌ Poor |
| **Complex reasoning** | ✅ Best available | ⚠️ Good enough | ⚠️ Limited | ❌ No |
| **Trading/financial analysis** | ✅ Full capability | ✅ Works well | ⚠️ Basic only | ❌ Don't trust it |
| **Long context (big files)** | ✅ 200K tokens | ✅ 128K+ | ⚠️ 8-32K typical | ❌ 4K typical |
| **Memory/persistence** | ✅ Excellent | ✅ Good | ⚠️ Forgets more | ❌ Very limited |

### Real Talk: Can You Do What We Do?

**What we built with Claude Opus:**
- Automated trading alerts with position guards
- Multi-API integrations (brokerage, news, market data)
- Self-maintaining memory system with semantic search
- Scheduled tasks, scanners, monitoring
- Complex multi-step workflows that just work

**Could you do this with other models?**

| Model | Verdict |
|-------|---------|
| **Claude Opus** | ✅ Yes — this is what we use. Handles complex autonomous tasks reliably. |
| **Claude Sonnet** | ✅ Mostly — 80% of tasks work fine. Struggles with very complex multi-step reasoning. Good for cost savings on routine work. |
| **GPT-4o** | ✅ Mostly — capable but sometimes needs more hand-holding. Tool use is solid. |
| **Llama 70B** | ⚠️ Partially — can do simpler automations. Multi-step chains break more often. Wouldn't trust it for trading. |
| **Llama 8B / Small models** | ❌ No — fine for chat, not for autonomous work. Will hallucinate tool calls, forget context, make bad decisions. |

**Bottom line:** 
- For **simple automation** (reminders, basic scripts, chat) → any model works
- For **serious work** (trading, complex workflows, reliability matters) → Claude Opus/Sonnet or GPT-4o
- **Local models** are great for privacy and cost, but you trade capability

**Recommendations:**
- **Just starting?** → Claude Sonnet 3.5 (best value)
- **Need maximum capability?** → Claude Opus 4
- **On a budget?** → OpenRouter with free models, or Gemini
- **Privacy-focused?** → Local Llama via Ollama (accept the tradeoffs)

---

## 🪟 Windows Users: Install WSL First

> **Already have WSL?** Skip to [Quick Install](#-quick-install)

### Step 1: Open PowerShell as Administrator

1. Press `Windows Key`
2. Type `PowerShell`
3. Right-click → **"Run as administrator"**
4. Click **Yes** if prompted

### Step 2: Install WSL

Copy and paste this command, then press Enter:

```powershell
wsl --install
```

Wait for it to finish (2-5 minutes).

### Step 3: Restart Your Computer

Seriously, restart. It won't work otherwise.

### Step 4: Set Up Ubuntu

After restart:

1. **Ubuntu** will open automatically (or find it in Start menu)
2. Wait for "Installing, this may take a few minutes..."
3. Create a **username** (lowercase, no spaces) — e.g., `steven`
4. Create a **password** (you'll type it twice, it won't show characters — that's normal)

### Step 5: You're Ready!

You should see something like:
```
steven@DESKTOP-ABC123:~$
```

Now continue to Quick Install below. ⬇️

---

## 🐧 Linux/VPS Users: Prerequisites

Make sure you have:

```bash
# Update your system first
sudo apt update && sudo apt upgrade -y

# These should already be installed, but just in case:
sudo apt install -y curl git
```

---

## 🚀 Quick Install

Copy this ONE command and paste it into your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
```

### What Happens Next

The script will:

1. ✅ Install Node.js 22 (takes ~1 min)
2. ✅ Install OpenClaw (takes ~30 sec)
3. ✅ Create your workspace
4. ❓ Ask: **"Install Public.com trading skill?"** → Type `y` or `n`
   - This is optional — adds stock/options trading via [Public.com](https://public.com)
   - If you don't trade, just type `n`
5. ❓ Ask: "Enter your API key" → Paste your Anthropic/OpenAI key
6. ❓ Ask: "Set up as background service?" → Type `y` for always-on

**Total time: ~5 minutes**

---

## ✅ After Installation

### Start OpenClaw

```bash
openclaw gateway
```

### Check if it's working

```bash
openclaw health
```

You should see: `Gateway: healthy`

### Connect Discord (Optional)

```bash
openclaw channels login discord
```

### Connect WhatsApp (Optional)

```bash
openclaw channels login whatsapp
```

Scan the QR code with your phone.

---

## 🔧 Common Issues

### "openclaw: command not found"

Run this, then try again:

```bash
source ~/.bashrc
```

### "Permission denied"

Run the original command with `bash` explicitly:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh)"
```

### WSL won't start

In PowerShell (Admin):

```powershell
wsl --shutdown
```

Then reopen Ubuntu.

### Something else broke

```bash
openclaw doctor
```

This will diagnose and suggest fixes.

---

## 📁 Where Things Live

| What | Location |
|------|----------|
| Config file | `~/.openclaw/openclaw.json` |
| Workspace | `~/.openclaw/workspace/` |
| Logs | `/tmp/openclaw/` |
| Credentials | `~/.openclaw/credentials/` |

---

## 🆘 Get Help

- **Docs:** [docs.openclaw.ai](https://docs.openclaw.ai)
- **Discord:** [discord.com/invite/clawd](https://discord.com/invite/clawd)
- **GitHub:** [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)

---

## ⚠️ Risks & Considerations

Before running any AI agent on your system, understand the risks:

| Risk | Severity | What Could Happen | Mitigation |
|------|----------|-------------------|------------|
| **Unintended file access** | Medium | AI reads sensitive files (keys, passwords, documents) | Use sandboxing, restrict paths in config |
| **Unintended commands** | High | AI runs destructive commands (`rm -rf`, etc.) | Use allowlist, dedicated user account |
| **API cost overruns** | Medium | Expensive model + long tasks = high bills | Set spending limits in provider dashboard |
| **Data exfiltration** | Low | AI could send your data to external services | Monitor network, use local models |
| **Prompt injection** | Low | Malicious content tricks AI into bad actions | Don't process untrusted inputs |
| **Always-on access** | Medium | Background service has persistent system access | Use Docker/VM, disable when not needed |

### Risk Tolerance Guide

| You Are... | Recommended Setup | Why |
|------------|-------------------|-----|
| **Cautious beginner** | Docker container or dedicated VPS | Maximum isolation, can't touch your files |
| **Developer testing** | Dedicated WSL instance | Isolated but easy to access |
| **Power user** | Dedicated user + path restrictions | Balance of convenience and safety |
| **Living dangerously** | Default install | Full access, maximum capability |

**Key principle:** The AI has exactly as much access as you give it. Start restricted, loosen as you build trust.

---

## 🔒 Security & Sandboxing

OpenClaw can execute commands on your system. For maximum security, consider these isolation options:

### Option 1: Dedicated WSL Instance (Recommended for Windows)

Create a separate WSL distro just for OpenClaw:

```powershell
# In PowerShell (Admin)
wsl --install -d Debian
```

This keeps OpenClaw completely separate from your main Linux environment.

### Option 2: Dedicated User Account

Run OpenClaw as a separate user with limited permissions:

```bash
# Create a dedicated user
sudo adduser openclaw-user

# Switch to that user
sudo su - openclaw-user

# Run the installer as this user
curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
```

### Option 3: Docker Container (Most Isolated)

```bash
docker run -it --name openclaw-sandbox \
  -v openclaw-data:/root/.openclaw \
  -p 18789:18789 \
  ubuntu:22.04 bash

# Inside container, run the setup
apt update && apt install -y curl
curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
```

### Option 4: VPS/Cloud Instance

Run OpenClaw on a cheap VPS ($5-10/month) instead of your local machine:
- [Hostinger VPS](https://www.hostinger.com/cart?product=vps%3Avps_kvm_2&period=12&referral_type=cart_link&REFERRALCODE=OTPSTEVENUND&referral_id=019ca6fa-37b1-7185-9f01-558947d58190) ⭐ (what we use — great value, easy setup)
  - **When setting up:** Select **Ubuntu 22.04** as your OS (recommended)
- [DigitalOcean](https://digitalocean.com)
- [Linode](https://linode.com)
- [Vultr](https://vultr.com)
- [Hetzner](https://hetzner.com) (EU)

This provides complete isolation from your personal files.

### OpenClaw's Built-in Sandboxing

OpenClaw also has built-in tool restrictions. In `~/.openclaw/openclaw.json`:

```json
{
  "tools": {
    "exec": {
      "enabled": true,
      "allowlist": ["git", "node", "npm", "python3"],
      "denyPaths": ["/home/*/Documents", "/home/*/Pictures"]
    },
    "read": {
      "allowPaths": ["~/.openclaw/workspace"]
    },
    "write": {
      "allowPaths": ["~/.openclaw/workspace"]
    }
  }
}
```

### What OpenClaw CAN Access by Default

| Access | Scope |
|--------|-------|
| Read files | Anywhere (unless restricted) |
| Write files | Anywhere (unless restricted) |
| Run commands | Any command (unless restricted) |
| Network | Outbound to AI APIs |

### What OpenClaw CANNOT Do

| Blocked | Reason |
|---------|--------|
| Access other WSL distros | Separate filesystem |
| Access Windows files | Unless explicitly mounted |
| Run without your API key | No key = no AI |
| Survive reboot | Unless set up as service |

**Bottom line:** If you're security-conscious, use a dedicated WSL instance or Docker container. It takes 2 extra minutes and gives you peace of mind.

---

## 📄 License

MIT — use it however you want.

---

Made with ☀️ by [Sol](https://github.com/stevenartzt/Sol)
