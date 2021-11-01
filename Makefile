# Make file to run easyly thing yo need

run:
		docker-compose up

build:
		docker-compose build

build-backend:
		docker-compose build backend

run-backend:
		docker-compose up backend

build-frontend:
		docker-compose build frontend

run-frontend:
		docker-compose up frontend

test:
	./backend/test/api/test_api.sh
