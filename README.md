# SSH-Reverse-Tunnel

SSH Tunneling in a Docker wrapper


# Usage
```
docker run -e PORTS="container:host,container:host" -e TARGET_USER="user" -e TARGET_HOST="example.host.tld"
```

```
version: '2'
services:
  ssh-tunnel:
  image: andoo391/ssh-reverse-tunnel
  container_name: sshTunnel
  #OPTIONAL - Add ports you want to pass in from the host here
  #If direct connecting containers to the tunnel, then expose those ports to the host the same way
  ports:
    - "1234:1234"
    - "5678:5678"
  volumes:
    - /path/to/host_key_file:/ssh_key
  environment:
    - TARGET_HOST=example.host.tld
    - TARGET_USER=user
    - PORTS="container1:host1,container2:host2..."
  restart: unless-stopped
```

