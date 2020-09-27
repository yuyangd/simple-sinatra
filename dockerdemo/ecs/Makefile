include ./common.mk
# query current git commitsha
GIT_COMMIT_SHORT  ?= $(shell git rev-parse --short HEAD)
REPO			?= amyjdocker
IMAGE			?= sinatrademo
TAG				?= $(GIT_COMMIT_SHORT)
ACCOUNTID          = $(shell aws sts get-caller-identity --query Account --output text)

STACKNAME          = ${SERVICE_NAME}-${ENVIRONMENT_TYPE}-${APP_NAME}-ecs
TEMPLATEPATH       = ./cfn
DesiredCapacity = 1

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

check-params:
	@echo VPC is : ${VPCID}
	@echo AWS Account is: ${ACCOUNTID}
	@echo Subnet is: ${SubnetPrivateA} ${SubnetPrivateB} ${SubnetPrivateC}

clean-up:
	./pipeline/cleanup.sh

deploy:
	@echo "Deploy app stack: ${STACKNAME}..."
	./pipeline/deploy.sh

.PHONY: deploy clean-up check-params build

