# 🧱 EKS Platform Modules

This project is an evolving collection of modular, production grade OpenTofu modules designed to simplify the provisioning of an Amazon EKS-based Kubernetes platform on AWS.

While currently in development, the goal is to provide a complete set of reusable infrastructure components to spin up EKS clusters with all essential services. This will including monitoring, secrets management, TLS, ingress, GitOps, workload identity and many more.

Each module is designed to be easy to consume, reusable and flexible enough to integrate into any project.


## Module List 

- [`eks-cluster`](./modules/eks-cluster) – Provisions EKS control plane


## 🚀 TODO

### ✅ Core Infrastructure
- [x] Control Plane Module  
- [ ] Managed NodeGroups Module  
- [ ] Fargate Module  
- [ ] Karpenter Module  
- [ ] Cluster Autoscaler Module

### 🔐 Security & Identity
- [ ] External Secrets Operator Module  
- [ ] Service Accounts (Pod Identity Agent / IRSA / both)  
- [ ] Human Access (RBAC / EKS Access Entries)

### 🔄 CI/CD & GitOps
- [ ] ArgoCD Module  
- [ ] GitHub Actions Workflows 

### 🌐 Networking
- [ ] AWS ALB Ingress Controller Module 

### 📊 Observability 
- [ ] Kube Prometheus Stack 
- [ ] Alerting / Dashboards 
- [ ] Log Aggregation (eg. Loki/ Fluent bit / Fluentd)

### 🌍 Edge & Traffic Management
- [ ] Cloudflare DNS Management (for public domains)
- [ ] Cloudflare WAF Integration
- [ ] Cloudflare Proxy / SSL / CDN Setup
- [ ] Route 53 Private Hosted Zone (for internal service discovery)