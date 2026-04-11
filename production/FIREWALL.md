# Opening Port 8081 on Your VPS

## Quick Check — Is It Already Open?

```bash
# Check if the app is listening on 8081
ss -tlnp | grep 8081

# Test locally
curl http://localhost:8081/home
```

## Open Port 8081 Based on Your OS

### Ubuntu / Debian (UFW)

```bash
sudo ufw allow 8081/tcp
sudo ufw status
```

### CentOS / RHEL / Fedora (firewalld)

```bash
sudo firewall-cmd --permanent --add-port=8081/tcp
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports
```

### Debian (iptables)

```bash
sudo iptables -A INPUT -p tcp --dport 8081 -j ACCEPT
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

## Cloud Provider Firewall (Most Common Blocker)

If you opened the port on your VPS but still can't reach it from outside, **check your cloud provider's firewall/security group**. This is the #1 reason ports appear closed.

| Provider | Where to Look |
|----------|---------------|
| **AWS** | EC2 → Security Groups → Inbound Rules → Add port 8081 TCP from 0.0.0.0/0 |
| **DigitalOcean** | Networking → Firewalls → Inbound Rules → Add port 8081 TCP |
| **Linode** | Firewall rules → Add port 8081 TCP |
| **Hetzner** | Cloud Console → Security Groups → Add port 8081 TCP |
| **Vultr** | Firewall → Add rule for port 8081 TCP |

## Verify From Outside

```bash
# From your local machine, test the public IP:
curl http://YOUR_VPS_PUBLIC_IP:8081/home

# Or use an online port checker:
# https://www.yougetsignal.com/tools/open-ports/
```

## Security Note

Exposing port 8081 directly is fine for testing. For production, it's better to put Nginx in front with HTTPS — see the `DEPLOY.md` file for Nginx + Let's Encrypt setup.