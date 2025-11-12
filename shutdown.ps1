# Shutdown RSVP Kubernetes Application

Write-Host "Shutting down RSVP Application..." -ForegroundColor Yellow

# Stop any port-forward processes
Get-Process powershell -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*port-forward*rsvp*"
} | Stop-Process -Force -ErrorAction SilentlyContinue

# Delete namespace (removes everything)
kubectl delete namespace rsvp

Write-Host "`nShutdown complete!" -ForegroundColor Green
Write-Host "All RSVP resources have been removed." -ForegroundColor Gray

