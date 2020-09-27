#!/bin/bash


aws cloudformation deploy \
    --template-file "${TEMPLATEPATH}/ecs.yaml" \
    --stack-name ${STACKNAME} \
    --parameter-overrides \
    "VPCId=${VPCID}" \
    "SubnetA=${SubnetPrivateA}" \
    "SubnetB=${SubnetPrivateB}" \
    "SubnetC=${SubnetPrivateC}" \
    "SecurityIngressCidrIp=${Internal_CiderIp}" \
    "DesiredCount=${DesiredCapacity}" \
    "CostCentre=${COSTCENTRE}" \
    "Gitsha=${GIT_COMMIT_SHORT}" \
    "DockerRepo=${REPO}/${IMAGE}" \
    "EnvironmentType=${ENVIRONMENT_TYPE}" \
    "Service=${SERVICE_NAME}" \
    "AppName=${APP_NAME}" \
    --tags \
    "ServiceName=${SERVICE_NAME}" \
    "AppName=${APP_NAME}" \
    "Environment=${ENVIRONMENT_TYPE}" \
    "GitCommit=${GIT_COMMIT_SHORT}" \
    "CostCentre=${COSTCENTRE}" \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM CAPABILITY_IAM CAPABILITY_AUTO_EXPAND
