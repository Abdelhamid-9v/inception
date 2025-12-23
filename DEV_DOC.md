# Developer Documentation
## 1. Setup
### Requirements
* Debian 11 or similar Linux.
* Docker & Docker Compose installed.
* `sudo` rights (needed to bind volumes).

### Configuration
* **Secrets:** Everything is in `srcs/.env`. Make sure `SQL_HOST=mariadb` matches the service name in docker-compose.
* **Domain:** Don't forget the `/etc/hosts` mapping! `127.0.0.1 abel-had.42.fr`.

## 2. Building
I use a standard `Makefile` workflow:

* **`make`**: Builds images if they don't exist, then runs `up -d`.
* **`make re`**: Forces a full rebuild of everything.
* **Rebuild just one thing:**
    If you are working on just WordPress, don't restart everything. Do this:
    ```bash
    docker-compose -f srcs/docker-compose.yml up -d --build wordpress
    ```

## 3. Container Management
* **Logs:** The most useful command.
    ```bash
    docker logs -f nginx
    docker logs -f mariadb
    ```
* **Shell Access:** To get inside a running container:
    ```bash
    docker exec -it wordpress /bin/bash
    ```

## 4. Data Storage (Persistence)
This was a specific requirement. Data must be in my home folder, but Docker has to "see" it as a named volume.

* **Location:**
    * DB: `/home/abel-had/data/mariadb`
    * WP: `/home/abel-had/data/wordpress`

* **How it works:**
    In `docker-compose.yml`, I used the `local` driver with `o: bind`. This tricks Docker into listing the volume in `docker volume ls` while actually storing the files where I want them.

* **Verify it:**
    ```bash
    docker volume inspect srcs_mariadb
    ```
    Look for `"device": "/home/abel-had/data/mariadb"`.