# Make file to run easyly thing you need

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

repo:
	git remote add kube git@github.com:Wbebey/timemanager.git && \
	git remote -v

push:
	docker push wbarmis/timemanager:backend && \
	docker push wbarmis/timemanager:frontend

kube_delete:
	kubectl delete deployment backend-deployment-prod  --namespace timemanager-25-prod && \
	kubectl delete deployment frontend-deployment-prod  --namespace timemanager-25-prod

kube_deploy:
	cd ci/kubernetes && \
	kubectl apply -f namaspace.yaml && \
	kubectl apply -f configmaps.yaml && \
	kubectl apply -f secrets.yaml  && \
	kubectl apply -f backend.yaml && \
	kubectl apply -f frontend.yaml && \
	kubectl apply -f database.yaml

deploy: 
	@$(MAKE) build
	@$(MAKE) push
	@$(MAKE) kube_delete
	@$(MAKE) kube_deploy


.PHONY: run build build-backend run-backend build-frontend run-frontend test push kube_deploy kube_delete deploy repo