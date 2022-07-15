## Installare argo nel cluster

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

## recupera il nome server:

kubectl get service argocd-server -n argocd --output=jsonpath='{.status.loadBalancer.ingress[0].hostname}'

kubectl port-forward svc/argocd-server -n argocd 8888:443

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo



argocd login localhost --username admin --password PSqb-0RJw8S2NdhH

argocd proj create hazelproject -d https://kubernetes.default.svc,argocd -s https://github.com/H-AlessioMurta/castinghazel.git


 argocd app create app-of-apps \
 --repo https://github.com/H-AlessioMurta/castinghazel.git \
 --path app-of-apps \
 --dest-server https://kubernetes.default.svc \
 --dest-namespace argocd