az login
az aks get-credentials --name sample-cluster

# Set kubectl context to our cluster
kubectl config use-context sample-cluster

# Creating a deployment with 3 pods (replicas)
kubectl create deployment hello-world-loadbalancer `
    --image=us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0 `
    --replicas=3

# Define type for our deployment
kubectl expose deployment hello-world-loadbalancer `
    --port=80 `
    --target-port=8080 `
    --type LoadBalancer

# This will take a minute for the load balancer to provision and get an public IP. Until then, result from below command's EXTERNAL-IP column will be display as 'Pending'
kubectl get service

$LOADBALANCERIP = $(kubectl get service hello-world-loadbalancer -o jsonpath='{ .status.loadBalancer.ingress[].ip }')
curl http://$LOADBALANCERIP

# Removing resources
kubectl delete deployment hello-world-loadbalancer
kubectl delete service hello-world-loadbalancer