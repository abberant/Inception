MDB_VOL_DIR		=		/home/$(USER)/data/mariadb
WP_VOL_DIR		=		/home/$(USER)/data/wordpress

all: check_volumes
	docker-compose -f ./srcs/docker-compose.yml up --build -d

up:
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker-compose -f ./srcs/docker-compose.yml down -v
	sudo rm -rf ${MDB_VOL_DIR}
	sudo rm -rf ${WP_VOL_DIR}

volumes:
	mkdir -p ${MDB_VOL_DIR}
	mkdir -p ${WP_VOL_DIR}

check_volumes:
	@if [ ! -d "${MDB_VOL_DIR}" ]; then \
		$(MAKE) volumes; \
	fi
	@if [ ! -d "${WP_VOL_DIR}" ]; then \
		$(MAKE) volumes; \
	fi
	

re: clean volumes all

fclean: clean
	docker system prune -a -f
	docker volume prune -f
	docker network prune -f
	docker container prune -f
	docker image prune -f