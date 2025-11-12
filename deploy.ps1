# Deploy RSVP Kubernetes Application

Write-Host "Deploying RSVP Application..." -ForegroundColor Cyan

# Part 1
Write-Host "Part 1: Basic Deployment" -ForegroundColor Yellow
kubectl apply -f part-1/namespace.yaml
kubectl apply -f part-1/ -R

# Part 2
Write-Host "Part 2: Configuration Management" -ForegroundColor Yellow
kubectl apply -f part-2/secrets.yaml
kubectl apply -f part-2/configmaps.yaml
kubectl apply -f part-2/ -R

# Part 3
Write-Host "Part 3: Persistent Storage" -ForegroundColor Yellow
kubectl apply -f part-3/mongo/pvc.yaml
kubectl apply -f part-3/ -R

# Part 4
Write-Host "Part 4: Ingress" -ForegroundColor Yellow
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml 2>&1 | Out-Null
Start-Sleep -Seconds 3
kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s 2>&1 | Out-Null
kubectl apply -f part-4/ingress.yaml 2>&1 | Out-Null
kubectl apply -f part-4/ -R 2>&1 | Out-Null

# Part 5
Write-Host "Part 5: Production Readiness" -ForegroundColor Yellow
kubectl apply -f part-5/pdb.yaml
kubectl apply -f part-5/deployments/ -R

Write-Host "`nDeployment complete!" -ForegroundColor Green
Write-Host "Waiting for pods to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 10
kubectl wait --for=condition=ready pod -l app=rsvp -n rsvp --timeout=120s 2>&1 | Out-Null

Write-Host "`nStarting port-forward..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "kubectl port-forward -n rsvp svc/rsvp 31000:5000" -WindowStyle Minimized

Start-Sleep -Seconds 3
Write-Host "Port-forward started in background window" -ForegroundColor Green
Write-Host "Open: http://localhost:31000" -ForegroundColor Cyan
Write-Host "`nTo stop port-forward, close the minimized PowerShell window" -ForegroundColor Gray

