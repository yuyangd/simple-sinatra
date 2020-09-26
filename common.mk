### Keypair that used to ssh to EC2 instance
KEY_NAME          ?= non-prod-eks-key
###Your VPC ID
VPCID             ?= vpc-00e0f51c0e0dce206
### VPC subnet 'Name' tag that will be used to query Subnet ID within the above VPC
VPC_Subnet_Tag    ?= non-production-private*
### Internal_Cider IP range that is allowed to ssh on 22 port, and access 80
Internal_CiderIp  ?= 10.0.0.0/8

ENVIRONMENT_TYPE   = nonprod
SERVICE_NAME       = platform
APP_NAME   		   = app
COSTCENTRE         = platform

SubnetPrivateA     = $(shell aws ec2 describe-subnets --query 'Subnets[].SubnetId' --filters Name=tag:Name,Values='${VPC_Subnet_Tag}' Name=availabilityZone,Values=ap-southeast-2a --output text)
SubnetPrivateB     = $(shell aws ec2 describe-subnets --query 'Subnets[].SubnetId' --filters Name=tag:Name,Values='${VPC_Subnet_Tag}' Name=availabilityZone,Values=ap-southeast-2b --output text)
SubnetPrivateC     = $(shell aws ec2 describe-subnets --query 'Subnets[].SubnetId' --filters Name=tag:Name,Values='${VPC_Subnet_Tag}' Name=availabilityZone,Values=ap-southeast-2c --output text)
