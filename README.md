*This project has been created as part of the 42 curriculum by abel-had.*

# Inception

## Description
This project aims to broaden knowledge of system administration by using Docker to virtualize several images and create a personal web infrastructure. The goal is to set up a multi-service architecture (NGINX, WordPress, MariaDB, etc.) running in separate containers, orchestrated by Docker Compose, on a Virtual Machine.

## Instructions
### Prerequisites
* Docker & Docker Compose installed on a Virtual Machine.
* Make.
* Administrative privileges (sudo).

### Installation & Execution
1.  **Setup Environment Variables:**
    Ensure the `.env` file is present in `srcs/` (see `DEV_DOC.md` for details).
2.  **Build and Run:**
    Run the following command at the root of the project:
    ```bash
    make
    ```
    This will build the Docker images and start the containers in the background.
3.  **Stop the Project:**
    ```bash
    make down
    ```

## Project Description & Design Choices
This project uses **Docker** to containerize services. Each service (NGINX, MariaDB, WordPress) runs in its own isolated container, communicating via a dedicated Docker network.

### Virtual Machines vs Docker
* **Virtual Machines (VMs):** Virtualize the entire hardware. Each VM runs a full Operating System (Kernel + User Space) on top of a Hypervisor. They are heavy and resource-intensive but offer complete isolation.
* **Docker Containers:** Virtualize at the OS level. Containers share the host system's Kernel but have isolated User Spaces (bins/libs). They are lightweight, start instantly, and are more efficient than VMs.

### Secrets vs Environment Variables
* **Environment Variables:** Stored in plain text (often in `.env` files). They are easy to use but less secure because they can be visible in logs or `docker inspect`.
* **Docker Secrets:** Encrypted data stored on the filesystem, accessible only to the services that need them. They are more secure and prevent sensitive data from leaking into environment settings. *Note: In this project, strict adherence to the subject required using `.env` files, though secrets are the industry standard for production.*

### Docker Network vs Host Network
* **Host Network:** The container shares the exact IP and port space of the host machine. There is no isolation; if a container listens on port 80, the host's port 80 is used.
* **Docker Network (Bridge):** Creates an isolated internal network. Containers have their own IP addresses and can talk to each other by name (DNS). Ports must be explicitly "mapped" (exposed) to be accessible from the host.

### Docker Volumes vs Bind Mounts
* **Bind Mounts:** Link a specific folder on your Host Machine (e.g., `/home/abel-had/data`) to a folder in the container. They rely on the host's specific file structure.
* **Docker Volumes:** Managed completely by Docker (usually stored in `/var/lib/docker/volumes`). They are safer, easier to back up, and independent of the host's folder structure.

## Resources
### References
* [Docker Documentation](https://docs.docker.com/)
* [NGINX Documentation](https://nginx.org/en/docs/)
* [WordPress Codex](https://codex.wordpress.org/)
* [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
