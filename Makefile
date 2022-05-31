SRCS 			= ./srcs
DOCKER			= sudo docker
COMPOSE 		= cd srcs/ && sudo docker-compose
DATA_PATH 		= /home/rvan-aud/data

.PHONY : all build up down clean fclean re

all		:	build
			sudo mkdir -p $(DATA_PATH)
			sudo mkdir -p $(DATA_PATH)/wordpress
			sudo mkdir -p $(DATA_PATH)/database
			sudo chmod 777 /etc/hosts
			sudo echo "127.0.0.1 rvan-aud.42.fr" >> /etc/hosts
			sudo echo "127.0.0.1 www.rvan-aud.42.fr" >> /etc/hosts
			$(COMPOSE) up -d


#build or rebuild services
build	:
			$(COMPOSE) build

# Creates and start containers
up:
			${COMPOSE} up -d 

# Stops containers and removes containers, networks, volumes, and images created by up
down	:
			$(COMPOSE) down

# down and make sure every container is deleted, -v removes volumes, --rmi removes images
clean	:
			$(COMPOSE) down -v --rmi all

# cleans and makes sure every volume, network and image is deleted
fclean	:	clean
			$(DOCKER) system prune --volumes --all --force
			sudo rm -rf $(DATA_PATH)
			$(DOCKER) network prune --force
			echo docker volume rm $(docker volume ls -q)
			$(DOCKER) image prune --force

re		:	fclean all

# Demande dans la fiche de correction
# correc	:
# 			@ sudo docker stop $(docker ps -qa)
# 			@ sudo docker rm $(docker ps -qa) 
# 			@ sudo docker rmi -f $(docker images -qa)
# 			@ sudo docker volume rm $(docker volume ls -q)
# 			@ sudo docker network rm $(docker ls -q)