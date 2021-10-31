# Make file to run easyly thing yo need

run:
		docker-compose up

build:
		docker-compose build

build-api:
		docker-compose build backend

run-api:
		docker-compose up backend

build-front:
		docker-image build frontend

run-front:
		docker-compose up frontend

test:
	./backend/test/api/test_api.sh
