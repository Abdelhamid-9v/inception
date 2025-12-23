# User Documentation

## Services Provided
This stack provides a fully functional web infrastructure containing:
1.  **WordPress Website:** A blogging platform.
2.  **MariaDB:** The database storing the website's data.
3.  **NGINX:** The web server handling secure (HTTPS) connections.
4.  **Adminer:** A web interface to manage the database.
5.  **FTP Server:** Allows file transfer to the website.
6.  **Redis:** Caching system to speed up the website.
7.  **Static Website:** A simple HTML resume/showcase page.

## How to Start and Stop
To control the project, open a terminal in the project root:

* **Start:** `make`
    * *Wait a few seconds for all services to initialize.*
* **Stop:** `make down`
* **Restart/Rebuild:** `make re`

## Accessing the Services
Once the project is running, you can access the services via your browser using the configured domain name:

| Service | URL | Description |
| :--- | :--- | :--- |
| **WordPress** | `https://abel-had.42.fr` | Main website |
| **Adminer** | `http://abel-had.42.fr:8080` | Database Management |
| **Static Site** | `http://abel-had.42.fr:1337` | Custom static page |

*Note: You must accept the "Self-Signed Certificate" warning in your browser (this is normal for a local development setup).*

## Credentials
Credentials are pre-configured in your `.env` file. Here is the summary for quick access:

* **WordPress Admin:**
    * User: `abel-had42`
    * Password: `Abdelhamid@123`
* **Database Root:**
    * Password: `Abdelhamid@123`
* **FTP Access:**
    * Host: `abel-had.42.fr` `or` `localhost` (Port 21)
    * User: `abel-had`
    * Password: `ftp@123`

## Checking Service Status
To verify everything is running correctly:
1.  Run `docker ps` in your terminal. You should see containers for: `nginx`, `wordpress`, `mariadb`, `ftp`, `redis`, `adminer`, `website`.
2.  Check logs for a specific service if something isn't working:
    `docker logs <container_name>` (e.g., `docker logs nginx`)