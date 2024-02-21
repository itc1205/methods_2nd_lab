.PHONY:
PROJECT_NAME = methods_2nd_lab
SWAGGER_GENERATOR = docker run --rm -it  --user $(shell id -u):$(shell id -g) -e GOPATH=$(shell go env GOPATH):/go -v ${HOME}:${HOME} -w "$(shell pwd)" quay.io/goswagger/swagger
GENERATE_ARGS = server -t gen -f ./api/api.swagger.yaml --exclude-main -A ${PROJECT_NAME}

run-server:
	go run ./cmd/server

database-up:
	docker-compose up -d

database-down:
	docker-compose down --remove-orphans

migrate-up:
	sql-migrate up & make migrate-status

migrate-down:
	sql-migrate down & make migrate-status

migrate-status:
	sql-migrate status

generate-api-from-docs:
	$(SWAGGER_GENERATOR) generate $(GENERATE_ARGS)