#!/bin/bash


aws cloudformation deploy \
    --template-file "${TEMPLATEPATH}/ec2.yaml" \
    --stack-name ${STACKNAME} \
    --parameter-overrides \
    "KeyName=${KEY_NAME}" \
    "VpcId=${VPCID}" \
    "EC2Type=${InstanceType}" \
    "SubnetPrivateA=${SubnetPrivateA}" \
    "SubnetPrivateB=${SubnetPrivateB}" \
    "SubnetPrivateC=${SubnetPrivateC}" \
    "CidrIp=${Internal_CiderIp}" \
    "ScalingDesiredCapacity=${ScalingDesiredCapacity}" \
    "ScalingMinCapacity=${ScalingMinCapacity}" \
    "ScalingMaxCapacity=${ScalingMaxCapacity}" \
    "CostCentre=${COSTCENTRE}" \
    "AmiID=${AmiID}" \
    "Gitsha=${GIT_COMMIT_SHORT}" \
    --tags \
    "ServiceName=${SERVICE_NAME}" \
    "AppName=${APP_NAME}" \
    "Environment=${ENVIRONMENT_TYPE}" \
    "GitCommit=${GIT_COMMIT_SHORT}" \
    "CostCentre=${COSTCENTRE}" \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM CAPABILITY_IAM CAPABILITY_AUTO_EXPAND
