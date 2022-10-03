az login
az aks get-credentials --name sample-cluster

# Set kubectl context to our cluster
kubectl config use-context sample-cluster

$Namespace = 'production'
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx `
    --create-namespace `
    --namespace $Namespace `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz

kubectl --namespace $Namespace get services -o wide -w ingress-nginx-controller

kubectl apply -f .\03-deployment-ingress-controller.yaml --namespace $Namespace
kubectl apply -f .\03-deployment-ingress-controller1.yaml --namespace $Namespace