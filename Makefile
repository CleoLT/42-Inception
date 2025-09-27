
RESET = \033[0m
PINK  = \033[1;35m



MKDIR = mkdir -p
RM    = rm -rf


SRCS_DIR = srcs/
VOL_DIR	 = /home/cle-tron/data/

MARIADB_VOL   = $(VOL_DIR)mariadb
WORDPRESS_VOL = $(VOL_DIR)wordpress

DC_FILE  = $(SRCS_DIR)docker-compose.yml



all: volumes build up

volumes:
	@echo "$(PINK)making volumes directories...$(RESET)"
	@$(MKDIR) $(MARIADB_VOL) $(WORDPRESS_VOL)

build:
	@echo "$(PINK)building containers...$(RESET)"
	@docker compose -f $(DC_FILE) build

up:
	@echo "$(PINK)starting containers...$(RESET)"
	@docker compose -f $(DC_FILE) up -d

print:
	@echo "$(PINK)printing containers...$(RESET)"
	@docker compose -f $(DC_FILE) ps
down:
	@echo "$(PINK)shutting down containers...$(RESET)"
	@docker compose -f $(DC_FILE) down

clean: down

fclean: clean 
	@echo "$(PINK)removing volumes directories...$(RESET)"
	@$(RM) $(VOL_DIR)

re: fclean all

.PHONY: all volumes build up print down clean fclean re



