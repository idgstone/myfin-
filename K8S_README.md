# PerFin Kubernetes Deployment

## Quick Start

### Deploy to Kubernetes

```bash
# Create cluster
kind create cluster --name myfin

# Deploy base configuration
kubectl apply -k k8s/base/

# Verify
kubectl get pods
kubectl get svc
```

### Port Forward

```bash
kubectl port-forward svc/perfin-app 3000:80
```

Access: http://localhost:3000

## Configuration

- **Frontend**: port 3000
- **Backend**: port 8080
- **MySQL**: port 3306

## Auto-Scaling

HPA configured for:
- Min replicas: 3
- Max replicas: 5
- CPU threshold: 70%
- Memory threshold: 80%

Monitor scaling:
```bash
kubectl get hpa -w
```

## Monitoring

See docker-compose.yml for Prometheus/Grafana setup.

Prometheus: http://localhost:9090
Grafana: http://localhost:3001 (admin/admin)

## Files

- `k8s/base/deployment.yaml` - App deployment
- `k8s/base/service.yaml` - Service definitions
- `k8s/base/hpa.yaml` - Auto-scaling configuration
- `k8s/base/kustomization.yaml` - Kustomize base

