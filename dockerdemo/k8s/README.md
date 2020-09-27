app-demo docker
===================================

- this is for sinatra app deploy on k8s (on port 3000).
- docker image has been build and pushed to hub repo: https://hub.docker.com/repository/docker/amyjdocker/sinatrademo

As a simple demo, I only build ruby script without configing ngnix into the docker image, to simply show that docker can be leveraged for easier deployment. 

k8s
===================================


# CI
* To build the image, run 
```
make build
```
it will build and push docker image to dockerhub (repo: amyjdocker/sinatrademo), I have built and pushed to my public dockerhub repo: amyjdocker/sinatrademo
* docker image is tagged with commitsha for versioning
* the latest image will be updated for each build (and by default, the deployment will take **latest** image)

# CD

## deploy on k8s:
1. you have deployed and login k8s cluster
2. run
``` 
make deploy 
```
3. once the pods up and running, you can get the external-ip to access webapp. run 
    ``` 
    kubectl get services -l app=preinterview -n preinterview-test
    ```
and access http://${external-ip}:3000/

- if you deploy to k8s on you laptop, the external-ip will be **localhost**
- if you deploy to cloud, the external-ip will be the loadbalancer url

