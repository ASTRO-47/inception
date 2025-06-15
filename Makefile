DATA_DIR = /home/iez-zagh/data
WP_DIR = $(DATA_DIR)/wp-data
DB_DIR = $(DATA_DIR)/db-data
COMPOSE = docker compose -f srcs/docker-compose.yml

.PHONY: build up upb down clean prepare

prepare:
	mkdir -p $(WP_DIR)
	mkdir -p $(DB_DIR)

build: prepare
	$(COMPOSE) build

upb: prepare
	$(COMPOSE) up --build -d

up: prepare
	$(COMPOSE) up -d

down:
	$(COMPOSE) down


# Add this new target
fclean: clean
	docker builder prune -af  # Clears build cache
	docker image prune -af    # Clears dangling images

# Modify clean to be more thorough
clean:
	sudo $(COMPOSE) down -v --rmi all
	rm -rf $(WP_DIR) $(DB_DIR)