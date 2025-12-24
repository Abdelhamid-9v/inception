NAME = inception
SRCS = ./srcs
COMPOSE_FILE = $(SRCS)/docker-compose.yml

# ⚠️ CHANGE THIS to your actual username if different!
DATA_PATH = /home/abdelhamid/data

# Docker Compose Command (Use 'docker-compose' if 'docker compose' fails)
DOCKER = docker compose --env-file $(SRCS)/.env -f $(COMPOSE_FILE)

all: up

# 1. Create the data folders (Required by subject)
# 2. Build and start the containers in the background
up:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	$(DOCKER) up -d --build

# Stop the containers
down:
	$(DOCKER) down

# Stop containers and remove images + volumes
clean:
	$(DOCKER) down --rmi all -v

# Deep clean: clean + wipe all data on your hard drive
fclean: clean
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -f -a
	@echo "Everything is clean."

# Rebuild everything from scratch
re: fclean all

.PHONY: all up down clean fclean re