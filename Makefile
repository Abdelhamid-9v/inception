SRCS = ./srcs
COMPOSE_FILE = $(SRCS)/docker-compose.yml

DATA_PATH = /home/abdelhamid/data
DOCKER = docker compose --env-file $(SRCS)/.env -f $(COMPOSE_FILE)

all: up
up:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	$(DOCKER) up -d --build

down:
	$(DOCKER) down

clean:
	$(DOCKER) down --rmi all -v

fclean: clean
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -f -a
	@echo "Everything is clean."

re: fclean all

.PHONY: all up down clean fclean re