az login
az aks get-credentials --name sample-cluster

# Set kubectl context to our cluster
kubectl config use-context sample-cluster


kubectl apply -f .\deploy-sample-cluster.yaml

# This will take a minute for the load balancer to provision and get an public IP. Until then, result from below command's EXTERNAL-IP column will be display as 'Pending'
kubectl get service

$LOADBALANCERIP = $(kubectl get service nginx -o jsonpath='{ .status.loadBalancer.ingress[].ip }')
curl http://$LOADBALANCERIP

# Removing resources
kubectl delete deployment nginx-deployment
kubectl delete deployment dotnet-deployment
kubectl delete service nginx
kubectl delete service dotnet1