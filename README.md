# SSH-Reverse-Tunnel

Quick and dirty SSH Tunneling in a Docker wrapper


# Setup

Basic bindings can be ```containerPort:sshPort```. If you want to bind the port to the equivalent on your jump server, you can also use ```containerPort``` by itself. You can include as many of these as you want in a comma-separated list, as long as nothing overlaps

*(Advanced: If you want to bind to a certain address in your container, you can specify the interface: ```containerPort:address:sshPort```. If the container is in **Bridge Mode**. you can specify another another container's name\*\* the same way: ```containerPort:containerName:sshPort``` )*

**: This only works if you've created the container with a user-defined bridge network, and have connected other containers to that same network. See more [here](https://docs.docker.com/network/bridge/#differences-between-user-defined-bridges-and-the-default-bridge)

Examples below:
|Ports to forward| Environment entry |
|---|---|
| 1234(Container) -> 1234(SSH Host)  |```1234``` OR ```1234:1234```   |
| 1234(Container) -> 5678(SSH Host)  |```1234:5678```   |
|127.0.0.1:1234(Container) -> 5678(SSH Host)|```1234:127.0.0.1:5678```|

# Install
|Environment Variable|Explanation|
|---|---|
|TARGET_HOST|SSH Server you want to listen on|
|TARGET_USER|SSH username|
|PORTS|Comma separated list of desired ports(outlined above)|
### Docker CLI
```
docker run -i \
-e PORTS="container:host,container:host" \
-e TARGET_USER="user" \
-e TARGET_HOST="example.host.tld" \
--volume /path/to/ssh_keyfile:/ssh_key \
andoo391/ssh-reverse-tunnel:latest
```

### Compose
```
version: '3'
services:
  ssh-tunnel:
    image: andoo391/ssh-reverse-tunnel:latest
    container_name: ssh_tunnel
    #OPTIONAL - Add ports you want to pass in from the host here
    #If in bridge mode, and you're connecting services to this network ONLY, then
    # you can expose their ports to the docker host here, if preferred
    volumes:
      - /path/to/ssh_keyfile:/ssh_key
    environment:
      - TARGET_HOST=example.host.tld
      - TARGET_USER=example_user
      #Put desired ports here, these are examples
      - PORTS=1234, 1234:5678, 443:127.0.0.1:443
    stdin_open: true 
    network_mode: "host"
    restart: unless-stopped
```

