include ./common.mk

.SILENT:
.EXPORT_ALL_VARIABLES:

ACCOUNTID          = $(shell aws sts get-caller-identity --query Account --output text)
GIT_COMMIT_SHORT   = $(shell git rev-parse --short HEAD)
STACKNAME          = ${SERVICE_NAME}-${ENVIRONMENT_TYPE}-${APP_NAME}
AmiID              = ami-0f87b0a4eff45d9ce
TEMPLATEPATH       = ./cfn
InstanceType       = t3.micro
ScalingDesiredCapacity = 1
ScalingMinCapacity = 1
ScalingMaxCapacity = 2

check-params:
	@echo VPC is : ${VPCID}
	@echo AWS Account is: ${ACCOUNTID}
	@echo Subnet is: ${SubnetPrivateA} ${SubnetPrivateB} ${SubnetPrivateC}
	@echo S3 bucket is: ${ACCOUNTID}-${STACKNAME}
	$(call check_s3,${ACCOUNTID}-${STACKNAME})

clean-up:
	./pipeline/cleanup.sh

create-s3:
	$(call check_s3,${ACCOUNTID}-${STACKNAME})
	aws s3api create-bucket --bucket ${ACCOUNTID}-${STACKNAME} --region ap-southeast-2 --create-bucket-configuration LocationConstraint=ap-southeast-2

upload-app:
	# FIXME: use git sha for zip file
	zip -vr src.zip src
	aws s3 cp src.zip s3://${ACCOUNTID}-${STACKNAME}

deploy: upload-app
	@echo "Deploy app stack: ${STACKNAME}..."
	./pipeline/deploy.sh

deploy-new: create-s3 deploy

.PHONY: deploy create-s3 clean-up upload-app check-params deploy-new

define check_s3
	echo "check s3 bucket"; \
        aws s3api head-bucket --bucket "$(1)" > /dev/null 2>&1; \
        if [ $$? != 0 ]; then \
                echo "Bucket $(1) does not exist, will create Bucket"; \
        else \
                echo "Bucket $(1) exists, delete bucket first!"; \
                exit 1; \
        fi;
endef