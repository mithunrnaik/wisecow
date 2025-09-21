# Wisecow : CI/CD Deployment to Minikube
This project demonstrates containerization, secure deployment, and CI/CD automation for a sample web application using Docker, Kubernetes (Minikube), and GitHub Actions.

## 📦 1. Containerization

The application is packaged using Docker:

```bash
docker build -t mithunrnaik/wisecow-app:latest .

docker run -p 4499:4499 mithunrnaik/wisecow-app:latest
```
The image is pushed to Docker Hub for deployment.

## ☸️ 2. Minikube Setup

Minikube is installed with the Docker driver:

```bash
minikube start --driver=docker
```

Cluster status is verified using:

```bash
kubectl get nodes
```

## 🔐 3. TLS & Ingress Configuration

- NGINX Ingress Controller and cert-manager are installed
- TLS certificates are issued via ClusterIssuer
- Ingress is configured to route HTTPS traffic to the application

## 📁 4. Kubernetes Manifests

All manifests are stored in the `k8s/` directory:

- `deployment.yaml`: App deployment
- `service.yaml`: ClusterIP service
- `ingress.yaml`: TLS-enabled ingress routing

Applied manually or via CI/CD:

```bash
kubectl apply -f k8s/deployment.yaml 
kubectl apply -f k8s/service.yaml 
kubectl apply -f k8s/ingress.yaml
```

## 🤖 5. GitHub Actions CI/CD Pipeline
Workflow file: `.github/workflows/ci-cd.yaml`

### Key Steps:

- Triggered on push to `main`
- Builds and pushes Docker image to Docker Hub
- Sets up `kubectl` and kubeconfig from GitHub Secrets
- Deploys to Minikube using inline `kubectl apply` commands

## 🧪 6. Verification
To confirm successful deployment:

```bash
kubectl get pods 
kubectl describe ingress 
kubectl get services
```

- Minikube IP: `minikube ip`
- Deployment is performed locally due to network isolation
- CI/CD automates image build and push; deployment is triggered from the self-hosted runner


## ✅ Outcome

CI/CD pipeline completes successfully on GitHub Actions, deploying the containerized app to Minikube with TLS and ingress routing.
