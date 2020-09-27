# query current git commitsha
GIT_COMMIT_SHORT  ?= $(shell git rev-parse --short HEAD)
REPO			  ?= amyjdocker
IMAGE			  ?= sinatrademo
TAG				  ?= $(GIT_COMMIT_SHORT)

.SILENT:
.EXPORT_ALL_VARIABLES:

build:
	@echo "build docker image ..."
	docker build \
		-t $(REPO)/$(IMAGE):$(TAG) \
		-t $(REPO)/$(IMAGE):latest \
		.
	###
	# uncomment below push command for after you change to your own $(REPO)
	###
	# docker push $(REPO)/$(IMAGE):$(TAG)
	# docker push $(REPO)/$(IMAGE):latest

deploy:
	kubectl apply -f pipeline/k8s-deploy.yaml
