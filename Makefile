uname_S := $(shell uname -s)

all: check-env build-local

check-env:
	@test -f README.md || { echo "You can create one starting do README.MD"; exit 1; }

build-local:
	cd backstage  && \
	yarn install --frozen-lockfile && \
	yarn tsc && \
	yarn build:backend --config ../../app-config.yaml && \
	docker image build . -f packages/backend/Dockerfile --tag backstage && \
	docker run --rm -it -p 7007:7007 backstage
	@echo "Application has been built succesfully." 

