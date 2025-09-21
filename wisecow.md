# Wisecow : CI/CD Deployment to Minikube
This project demonstrates containerization, deployment, and CI/CD automation for a application using Docker, Kubernetes (Minikube), and GitHub Actions.

## 📁 0. Prerequisites
- Docker installed

- Minikube installed

- kubectl installed

- GitHub repository cloned

- Docker Hub account

- GitHub Personal Access Token (PAT)

- GitHub Secrets configured:

    - DOCKER_USERNAME

    - DOCKER_PASSWORD

    - KUBECONFIG


## 📦 1. Containerization

The application is packaged using Docker:

Create Dockerfile

Build and run locally

```bash
docker build -t mithunrnaik/wisecow-app:latest .

docker run -p 4499:4499 mithunrnaik/wisecow-app:latest
```
The image is pushed to Docker Hub for deployment.

```bash
docker push mithunrnaik/wisecow-app:latest
```

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

Install NGINX Ingress Controller:

```bash
minikube addons enable ingress
```

Install cert-manager:
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.yaml
```

Create ClusterIssuer and run:
```bash
kubectl apply -f cluster-issuer.yaml
```

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
Create Workflow file: `.github/workflows/ci-cd.yaml`

### Key Steps:

- Builds and pushes Docker image to Docker Hub
- Sets up `kubectl` and kubeconfig from GitHub Secrets
- Deploys to Minikube using `kubectl apply` commands

## 🧑‍💻 6. Set Up Self-Hosted Runner

Register Runner:

On GitHub: Settings → Actions → Runners → New self-hosted runner

Follow the instructions to download and configure the runner.

Start Runner:

```bash
./run.sh
```

## 🧪 7. Verification
To confirm successful deployment:

```bash
kubectl get pods 
kubectl describe ingress 
kubectl get services
```

- Minikube IP: `minikube ip`

## 📝 Notes

- App is accessed via: `https://wisecow.127.0.0.1.nip.io`
- This uses [nip.io](https://nip.io), which maps subdomains to IPs automatically — no `/etc/hosts` edits needed
- TLS is enabled via cert-manager and ClusterIssuer
- Ingress is configured to route HTTPS traffic to the application
- Deployment is performed locally
- CI/CD automates image build and push; deployment is triggered from the self-hosted runner

## ✅ Outcome

CI/CD pipeline builds and pushes the Docker image, then deploys it to Minikube — all automated via GitHub Actions and a self-hosted runner.
