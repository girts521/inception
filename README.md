*This project has been created as part of the 42 curriculum by gikarcev.*

## Description
**Inception** is a System Administration project designed to broaden knowledge of Docker and container orchestration. The objective is to set up a small infrastructure composed of different services running under specific rules within a virtual machine, using Docker Compose. The architecture includes an NGINX server (TLS only), a WordPress site with PHP-FPM, and a MariaDB database, each isolated within its own dedicated container built from Alpine or Debian base images.

## Instructions
### Prerequisites
- Docker and Docker Compose installed on your system.
- `make` utility installed.
- Local host routing: Add the following line to your `/etc/hosts` file:
  `127.0.0.1 girts.42.fr`

### Execution
1. Clone the repository and navigate to the root directory.
2. Configure the required environment variables in `srcs/.env` and securely place your database credentials in the `secrets/` directory.
3. Run `make` (or `make all`) to build the Docker images and launch the containers in the background.
4. Access the website via `https://girts.42.fr`.
5. To gracefully stop the infrastructure, run `make down`. To completely clean up all containers, images, and volumes, run `make fclean`.

## Project Description & Technical Choices
This project strictly relies on Docker to build and manage a containerized infrastructure. Instead of pulling heavy, pre-configured images, custom Dockerfiles are written for NGINX, WordPress, and MariaDB. Each service runs in a single, dedicated container to enforce isolation. 

### Technical Comparisons
* **Virtual Machines vs Docker:** Virtual Machines run a full guest operating system on top of a hypervisor, which consumes significant hardware resources (CPU, RAM, storage) just to maintain the OS. Docker utilizes OS-level virtualization, allowing containers to share the host machine's kernel. This makes Docker containers significantly more lightweight, faster to boot, and efficient.
* **Secrets vs Environment Variables:** Environment variables are highly convenient for general configuration (like domain names) but are easily exposed through crash logs, debugging tools, or `docker inspect`. Docker Secrets provide a secure way to inject sensitive data (like database passwords) into containers, typically mounting them into a temporary, in-memory filesystem (`tmpfs`) where they cannot be easily leaked or committed to source control.
* **Docker Network vs Host Network:** Using the host network removes network isolation, attaching the container directly to the host's networking interfaces. This can cause port conflicts and security vulnerabilities. A custom Docker Network (bridge) creates an isolated, internal DNS space where containers can securely communicate with each other using their service names, while only selectively exposing required ports (like 443 for NGINX) to the outside world.
* **Docker Volumes vs Bind Mounts:** Bind mounts link a specific, absolute path on the host machine to a directory in the container, making the setup highly dependent on the host's specific filesystem structure and permissions. Docker Volumes are entirely managed by Docker, stored securely in Docker's designated storage area, and are much easier to back up, share across containers, and migrate without worrying about host OS constraints.

## Resources
* [Docker Documentation](https://docs.docker.com/)
* [NGINX Official Documentation](https://nginx.org/en/docs/)
* [MariaDB Documentation](https://mariadb.com/kb/en/)
* [WordPress Developer Resources](https://developer.wordpress.org/)

### AI Instructions
*During the development of this project, AI tools were utilized to generate the structural format of this README file, outline high-level project milestones, and explain the technical differences between Docker configurations (e.g., Volumes vs Bind Mounts). All final system configurations, Dockerfiles, and Makefile scripts were independently written, tested, and understood prior to submission.*
