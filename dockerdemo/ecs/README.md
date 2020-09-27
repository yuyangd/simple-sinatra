app-demo docker
===================================
- this is for sinatra app deploy on k8s (on port 3000).
- docker image has been build and pushed to hub repo: https://hub.docker.com/repository/docker/amyjdocker/sinatrademo

As a simple demo, I only build ruby script without configing ngnix into the docker image, to simply show that docker can be leveraged for easier deployment. 


ecs
===================================

# 1. Prerequisite

1. You have AWS account with VPC and 3 subnets configured
2. and your private subnets can access internet by NATGateway
3. You have installed awscli locally, and you have configured AWS creds in **credentials** file, with **region = ap-southeast-2**
4. Clone this repo to your local

# 2.Deploy

## Parameter
You will need to update the following 4 parameters from **common.mk** file.
1. Keypair that used to ssh to EC2 instance: **```KEY_NAME```**
2. Your VPC ID: **```VPCID```**
3. Internal_Cider IP range that is allowed to ssh on 22 port, and access the webapp 80 port: **```Internal_CiderIp```**
4. VPC subnets **Name** tag that will be used to query Subnet ID within the above VPC: **```VPC_Subnet_Tag```**
    * **Please note**: if your VPC subnets does not have **Name** tag, please remove the query and directly provide SubnetsID for parameters: SubnetPrivateA, SubnetPrivateB, SubnetPrivateC, eg: ```SubnetPrivateA=subnet-exampleid1234567```

## How to deploy

1. Before deploy, run:
    ```
    make check-params
    ```
   check output parameters, and verify the vpc and 3 subnets are all correct

2. If all parameters are correct, you can start deployment by run 
    ```
    make deploy
    ```
Wait for the stack creation complate (stack name: ${SERVICE_NAME}-${ENVIRONMENT_TYPE}-${APP_NAME}), come to the cloudformation console --> stack output, and simply click the LoadBalancerDNSName output url

## what resources will be created

ECS Fargate, IAM role and policy, ALB, SG

## Cleanup stack/resources
run
```
make clean-up
```
# 3.Design

- this demo simply build the app into docker image, and deploy it to ECS Fargate
- I used the similar methodology as EC2 solution (cloudformation + shell scripts + Makefile), details can be found on ec2 solution readme

## Others
1. consider to add Route53
2. ALB can be made public (ssl cert, change to port 443), using SG ingress to control access


