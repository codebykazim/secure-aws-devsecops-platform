# Linux Administration Commands

As a DevOps engineer, you need to know how to monitor and manage Linux servers. Here are essential commands you should practice on our new EC2 instances.

### 1. Check Memory and Swap (`free -h`)
Useful to see if Jenkins or Docker is consuming all your RAM. The `-h` flag makes it human-readable (Megabytes/Gigabytes).
```bash
free -h
```

### 2. Check Disk Space (`df -h`)
Useful to see if Docker images have filled up your hard drive storage.
```bash
df -h
```

### 3. Monitor Processes (`top` / `htop`)
Shows live CPU and RAM usage by process, similar to Task Manager on Windows.
```bash
htop
```
*(Press `q` to exit).*

### 4. Manage Services (`systemctl`)
Used to start, stop, or check the status of background system services (like Jenkins or Docker).
```bash
sudo systemctl status jenkins
sudo systemctl restart docker
```

### 5. View System Logs (`journalctl`)
Used to view system logs or service logs if something crashes and you need to investigate the Root Cause.
```bash
sudo journalctl -u jenkins -f
```
*(The `-f` flag "follows" the log live).*
