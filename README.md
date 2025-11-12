# RSVP Kubernetes Application

Kubernetes deployment for RSVP application with MongoDB.

## Quick Start

### Deploy Everything (Recommended)
```powershell
.\deploy.ps1
```

This script will:
- Deploy all 5 parts automatically
- Wait for pods to be ready
- Start port-forward automatically in a background window
- Display the access URL

Then open: **http://localhost:31000**

### Manual Deployment (Alternative)
If you prefer to deploy manually:
```bash
# Part 1: Basic deployment
kubectl apply -f part-1/namespace.yaml
kubectl apply -f part-1/ -R

# Part 2: ConfigMaps and Secrets
kubectl apply -f part-2/secrets.yaml
kubectl apply -f part-2/configmaps.yaml
kubectl apply -f part-2/ -R

# Part 3: Persistent storage
kubectl apply -f part-3/mongo/pvc.yaml
kubectl apply -f part-3/ -R

# Part 4: Ingress (optional)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
kubectl apply -f part-4/ingress.yaml
kubectl apply -f part-4/ -R

# Part 5: Production readiness
kubectl apply -f part-5/pdb.yaml
kubectl apply -f part-5/deployments/ -R

# Then start port-forward manually
kubectl port-forward -n rsvp svc/rsvp 31000:5000
```

### Shutdown
```powershell
.\shutdown.ps1
```

Or manually:
```bash
kubectl delete namespace rsvp
```

## Project Structure
- `part-1/` - Basic deployment (namespace, deployments, services)
- `part-2/` - Configuration management (ConfigMaps, Secrets)
- `part-3/` - Persistent storage (PVC)
- `part-4/` - Ingress & DNS
- `part-5/` - Production readiness (health checks, resource limits, PDBs)

