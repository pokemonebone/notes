# SSH-ключи для GitHub

Сгенерируй ключ (рекомендуется ed25519):

```bash
ssh-keygen -t ed25519 -C "you@example.com"
```

Скопируй публичный ключ и добавь в GitHub → Settings → SSH and GPG keys. Измени remote на SSH (если репозиторий был через HTTPS):

```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

## Дополнительная настройка `config`

GitHub использует порт 22 для SSH, но во многих сетях (особенно в офисах, учебных заведениях, VPN) он закрыт. GitHub поддерживает SSH через порт 443. В файле `~/.ssh/config` добавь

```
Host github.com
  Hostname ssh.github.com
  Port 443
  User git
  IdentityFile C:\Users\<твоё_имя>\.ssh\id_ed25519
```

Иногда Kaspersky, ESET, Windows Defender блокируют ssh.exe.
Попробуй временно отключить их или добавить
`C:\Program Files\Git\usr\bin\ssh.exe` в список разрешённых.
