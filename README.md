# OpenClaw Quickstart 🦞

One-command setup for OpenClaw on **WSL**, **Linux**, or **VPS**.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/stevenartzt/openclaw-quickstart/main/setup.sh | bash
```

Or clone and run:

```bash
git clone https://github.com/stevenartzt/openclaw-quickstart.git
cd openclaw-quickstart
./setup.sh
```

## What It Does

1. ✅ Detects your OS (WSL/Debian/RedHat/macOS)
2. ✅ Installs Node.js 22 via nvm
3. ✅ Installs OpenClaw globally
4. ✅ Creates workspace with starter files
5. ✅ Optionally installs Public.com trading skill
6. ✅ Runs the setup wizard for API keys
7. ✅ Optionally sets up as a background service (systemd)

## Requirements

- Linux, WSL, or macOS
- Internet connection
- API key from Anthropic, OpenAI, or OpenRouter

## After Setup

```bash
# Start the gateway
openclaw gateway

# Check health
openclaw health

# Connect Discord
openclaw channels login discord

# Connect WhatsApp
openclaw channels login whatsapp
```

## Configuration

Config file: `~/.openclaw/openclaw.json`

```json
{
  "agents": {
    "defaults": {
      "model": "anthropic/claude-sonnet-4-20250514",
      "workspace": "~/.openclaw/workspace"
    }
  },
  "channels": {
    "discord": {
      "token": "your-bot-token",
      "allowFrom": ["your-user-id"]
    }
  }
}
```

## Public.com Trading

If you installed the Public.com skill, add your credentials:

```bash
# Add to ~/.openclaw/.env
echo 'PUBLIC_COM_SECRET=your-api-secret' >> ~/.openclaw/.env
echo 'PUBLIC_COM_ACCOUNT_ID=your-account-id' >> ~/.openclaw/.env
```

Get your API secret at: https://public.com/settings/v2/api

## Running as a Service

The setup script can configure OpenClaw to run in the background automatically.

Manual setup:

```bash
# Enable the service
systemctl --user enable openclaw
systemctl --user start openclaw

# Check status
systemctl --user status openclaw

# View logs
journalctl --user -u openclaw -f
```

## Troubleshooting

### "openclaw: command not found"

```bash
# Reload shell
source ~/.bashrc

# Or add to PATH manually
export PATH="$HOME/.nvm/versions/node/v22.*/bin:$PATH"
```

### Gateway won't start

```bash
openclaw doctor
openclaw logs
```

### WSL networking issues

```powershell
# In PowerShell (Windows)
wsl --shutdown
# Then reopen WSL
```

## Links

- [OpenClaw Docs](https://docs.openclaw.ai)
- [GitHub](https://github.com/openclaw/openclaw)
- [Discord Community](https://discord.com/invite/clawd)
- [Public.com API](https://public.com/api/docs)

## License

MIT

---

Made with ☀️ by Sol
