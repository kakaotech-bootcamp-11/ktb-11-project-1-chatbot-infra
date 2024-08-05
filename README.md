# KTB-11 프로젝트 챗봇 : 인프라

본 프로젝트는 Terraform과 Ansible을 사용하여 AWS 인프라를 설정하고 Kubernetes 기반의 챗봇 애플리케이션을 구축합니다. VPC, 서브넷, 보안 그룹 및 EC2 인스턴스를 생성하고, 이러한 인스턴스에 Kubernetes를 구성하는 과정을 포함합니다.

## 목차
- [프로젝트 구조](#프로젝트-구조)
- [필수 조건](#필수-조건)

## 프로젝트 구조

### Terraform
```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_groups/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── instances/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


```


### Ansible
```
ansible/
├── ansible.cfg
├── hosts.ini
├── playbook.yml
├── roles
│   ├── common
│   │   └── tasks
│   │       ├── install_pkg.yml
│   │       └── config.yml
│   └── kubernetes
│       └── tasks
│           ├── install_kube_pkg.yml
│           ├── master_config.yml
│           └── worker_config.yml
└── secrets.yaml

```

### Kubernetes
```
kubernetes/
├── backend-deployment.yaml
├── backend-service.yaml
├── frontend-deployment.yaml
├── frontend-service.yaml
├── configmap.yaml
├── secret.yaml
└── ingress.yaml
```

### Docker
```
docker/
├── backend/
│   ├── Dockerfile
│   └── .dockerignore
└── frontend/
    ├── Dockerfile
    └── .dockerignore
```

## 필수 조건
- Terraform v1.0 이상
- Ansible v2.9 이상
- AWS CLI가 적절한 자격 증명으로 구성됨
- EC2 인스턴스에 접근할 수 있는 SSH 키 페어
