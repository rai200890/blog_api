.PHONY: up
up: down
	docker-compose up


.PHONY: build
build: down
	docker-compose \
	up --build

.PHONY: down
down:
	docker-compose down -v --remove-orphans

dev-shell: down
	docker-compose build

	docker-compose \
		run --name blog_app --rm --service-ports app sh -c "make db && /bin/sh"

test-shell: down
	docker-compose \
		-f docker-compose.yml \
		-f docker-compose.test.yml \
		build

	docker-compose \
		-f docker-compose.yml \
		-f docker-compose.test.yml \
		run --name blog_app --rm --service-ports app sh -c "make db && /bin/sh"


.PHONY: mix-deps
mix-deps:
	mix deps.get

.PHONY: wait-db
wait-db:
	@echo 'Waiting Postgres Server...'
	@while ! nc -z db 5432; do sleep 1; done

.PHONY: db
db: mix-deps wait-db
	mix do ecto.create, ecto.migrate

.PHONY: run-debug
run-debug:
	iex -S mix phx.server

