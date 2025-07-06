# 🧱 EKS Platform Modules

This project is an evolving collection of modular, production grade OpenTofu modules designed to simplify the provisioning of an Amazon EKS-based Kubernetes platform on AWS.

While currently in development, the goal is to provide a complete set of reusable infrastructure components to spin up EKS clusters with all essential services. This will including monitoring, secrets management, TLS, ingress, GitOps, workload identity and many more.

Each module is designed to be easy to consume, reusable and flexible enough to integrate into any project.


## Module List 

- [`eks-cluster`](./modules/eks-cluster) – Provisions EKS control plane
- [`eks-managed-nodegroup`](./modules/eks-managed-nodegroup) – Provisions EKS managed nodegroups.
- [`eks-fargate-profile`](./modules/eks-fargate-profile) – Provisions EKS Fargate Profiles.
- [`eks-core-ops-services`](./modules/eks-core-ops-services) – Provisions EKS core operations services such as the cluster autoscaler and metrics server. 


## 🚀 TODO

### ✅ Core Infrastructure
- [x] Control Plane Module  
- [x] Managed NodeGroup Module  
- [x] Fargate Module  


### ⚙️ Core Operational Services 
- [skip] CoreDNS  (Internal DNS): Deployed by EKS
- [skip] KubeProxy (Enable Kubernetes Services): Deployed by EKS 
- [skip] VPC CNI Plugin (Pod to Pod Networking): Deployed by EKS 
- [x] Metrics Server (For Pod Scaling Pipelines)
- [x] Cluster Austoscaler (Classic Nodescaling)
- [ ] Karpenter (Advanced Just in Time node scaling)
- [x] AWS ALB Controller (Enable Ingress)

### 🔐 Security & Identity
- [ ] External Secrets Operator Module  
- [x] Service Accounts (IRSA)  
- [x] Service Accounts (Pod Identity Agent)  
- [ ] Human Access (RBAC / EKS Access Entries)

### 🔄 CI/CD & GitOps
- [ ] ArgoCD Module  
- [ ] GitHub Actions Workflows 

### 🌐 Networking
- [x] AWS ALB Ingress Controller Module 

### 📊 Observability 
- [x] Kube Prometheus Stack 
- [ ] Alerting / Dashboards 
- [ ] Log Aggregation (eg. Loki/ Fluent bit / Fluentd)

### 🌍 Edge & Traffic Management
- [ ] Cloudflare DNS Management (for public domains)
- [ ] Cloudflare WAF Integration
- [ ] Cloudflare Proxy / SSL / CDN Setup
- [ ] Route 53 Private Hosted Zone (for internal service discovery)