## Installare argo nel cluster

kubectl create namespace hazel-argo
kubectl apply -n hazel-argo -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl patch svc argocd-server -n hazel-argo -p '{"spec": {"type": "LoadBalancer"}}'

## recupera il nome server:

kubectl get service argocd-server -n hazel-argo --output=jsonpath='{.status.loadBalancer.ingress[0].hostname}'

kubectl port-forward svc/argocd-server -n hazel-argo 8888:443

kubectl -n hazel-argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo



argocd login localhost --username admin --password C50e5JJ3Y4Hn7qVU

argocd proj create hz -d https://kubernetes.default.svc,hazel-argo -s https://github.com/H-AlessioMurta/castinghazel.git

argocd app create hzapp --repo https://github.com/H-AlessioMurta/castinghazel.git  \
--path  app-of-apps \
 --dest-server https://kubernetes.default.svc \
 --dest-namespace hazel-argo

 argocd app create hzc \
 --repo https://github.com/H-AlessioMurta/castinghazel.git \
 --path hazelcluster \
 --dest-server https://kubernetes.default.svc \
 --dest-namespace hazel-argo