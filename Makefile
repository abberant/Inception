all:
	docker-compose -f ./srcs/docker-compose.yml up --build

up:
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker-compose -f ./srcs/docker-compose.yml down -v

re: clean all

fclean: clean
	docker system prune -a -f
	docker volume prune -f
	docker network prune -f
	docker container prune -f
	docker image prune -f