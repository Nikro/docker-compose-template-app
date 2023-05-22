# About this project.
This is a tiny demo-project designed for:
- Blog Post - [Docker Compose based deployments](https://nikro.me/posts/docker-compose-based-deployments/). 
- [Docker Compose Deployment Template](https://github.com/Nikro/docker-compose-template) - used to deploy dev/prod projects using docker compose.

## CI/CD - Github Actions
For this project, you'll need to supply some secrets:

- `HOST_DEV` - host's IP address
- `PORT_DEV` - the SSH port open for connections
- `USERNAME_DEV` - the ssh username
- `PKEY_DEV` - the private key used to connect to the host