# Inception: Project Milestones
*This project has been created as part of the 42 curriculum by gikarcev.*

This document outlines the major milestones for completing the Inception project. It serves as a high-level roadmap to build a multi-container infrastructure using Docker Compose.

## Milestone 1: Project Skeleton and Configuration Foundation
**Goal:** Establish the required directory structure, environmental variables, and secure secret management.

- [ ] **Directory Scaffolding:** Create the exact folder hierarchy required (`srcs`, `secrets`, `requirements`, service folders, `conf`, `tools`).
- [ ] **Environment Variables:** Set up the `srcs/.env` file with required variables (e.g., domain name, basic database configuration).
- [ ] **Secret Management:** Create the `secrets/` directory and populate it with files containing passwords and credentials (ensure these are added to `.gitignore`).
- [ ] **Makefile Initialization:** Create the root `Makefile` and define the basic targets (`all`, `up`, `down`, `clean`, `fclean`) to interact with `docker-compose.yml`.
- [ ] **Local Domain Routing:** Modify the host machine's `/etc/hosts` file to route `[login].42.fr` to the local loopback address.

## Milestone 2: MariaDB Container Configuration
**Goal:** Build a standalone MariaDB container with persistent storage and a pre-configured database.

- [ ] **Dockerfile Creation:** Write the `Dockerfile` in `srcs/requirements/mariadb` using the penultimate stable version of Alpine or Debian.
- [ ] **Configuration Script:** Write a script (e.g., in the `tools` folder) to initialize the database, create the WordPress user, and set passwords securely upon container start.
- [ ] **Docker Compose Integration:** Add the MariaDB service to `docker-compose.yml`.
- [ ] **Volume Setup:** Define and link the named volume for database persistence.
- [ ] **Network Definition:** Define the custom Docker network in `docker-compose.yml` and attach the service.
- [ ] **Testing:** Build and run the container; verify the database initializes correctly and the user is created.

## Milestone 3: WordPress Container Configuration
**Goal:** Build a standalone container running WordPress and PHP-FPM, connected to the MariaDB service.

- [ ] **Dockerfile Creation:** Write the `Dockerfile` in `srcs/requirements/wordpress` (no NGINX allowed here).
- [ ] **PHP-FPM Setup:** Configure PHP-FPM to listen on the correct port (usually 9000) for incoming NGINX requests.
- [ ] **WordPress Installation:** Download and extract the WordPress core files.
- [ ] **WP-CLI Configuration (Recommended):** Use a script to automate the WordPress installation process, connecting it to the MariaDB database using the environment variables and secrets.
- [ ] **Docker Compose Integration:** Add the WordPress service to `docker-compose.yml`, attach it to the custom network, and configure the necessary volumes (website files).
- [ ] **Testing:** Verify the WordPress container starts and can communicate with the MariaDB container.

## Milestone 4: NGINX Container Configuration
**Goal:** Build the single entry point for the infrastructure, handling HTTPS traffic and routing requests to WordPress.

- [ ] **Dockerfile Creation:** Write the `Dockerfile` in `srcs/requirements/nginx`.
- [ ] **SSL/TLS Configuration:** Generate self-signed certificates and configure NGINX to only accept TLSv1.2 or TLSv1.3 on port 443.
- [ ] **Server Block Setup:** Configure NGINX to route PHP requests to the WordPress container's PHP-FPM service (via port 9000).
- [ ] **Docker Compose Integration:** Add the NGINX service to `docker-compose.yml`, expose port 443 to the host, attach it to the custom network, and link the WordPress file volume.
- [ ] **End-to-End Testing:** Start the entire stack using the `Makefile`. Access `https://[login].42.fr` in a browser and verify the WordPress installation page (or fully configured site) appears.

## Milestone 5: Documentation and Final Polish
**Goal:** Fulfill all mandatory documentation requirements and ensure the stack is robust.

- [ ] **README.md:** Write a comprehensive README detailing the project description, instructions, resources, and technical comparisons (VMs vs. Docker, Secrets vs. Env Vars, etc.).
- [ ] **USER_DOC.md:** Create the user documentation explaining how to use the stack, manage credentials, and access the site.
- [ ] **DEV_DOC.md:** Create the developer documentation detailing the setup, Makefile usage, and data persistence logic.
- [ ] **Resilience Testing:** Verify that containers restart automatically after a crash (e.g., by manually stopping a process inside a container).
- [ ] **Security Audit:** Ensure no passwords exist in Dockerfiles, no `latest` tags are used, and no infinite loops (`tail -f`, `sleep infinity`) are used as entry points.

## Milestone 6: Bonus (Optional)
*Note: Only attempt if the mandatory part is perfectly complete.*

- [ ] **Redis Cache:** Configure a Redis container and link it to WordPress for object caching.
- [ ] **FTP Server:** Set up an FTP container pointing to the WordPress volume.
- [ ] **Static Website:** Create a non-PHP static site in a separate container.
- [ ] **Adminer:** Deploy an Adminer container for database management.
- [ ] **Custom Service:** Deploy another useful service of your choice.
