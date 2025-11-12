# NGINX Ingress Controller Setup

To deploy the NGINX Ingress Controller, run:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
```

Wait for the ingress controller to be ready:

```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

## Update /etc/hosts (Windows)

Run PowerShell as Administrator and execute:

```powershell
Add-Content -Path C:\Windows\System32\drivers\etc\hosts -Value "127.0.0.1 rsvp.local"
```

Or manually edit `C:\Windows\System32\drivers\etc\hosts` and add:
```
127.0.0.1 rsvp.local
```

## Verify Ingress Controller

```bash
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```

