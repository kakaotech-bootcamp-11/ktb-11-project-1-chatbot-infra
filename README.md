# KTB-11 프로젝트 챗봇 : 인프라

본 프로젝트는 Terraform과 Ansible을 사용하여 AWS 인프라를 설정하고 Kubernetes 기반의 챗봇 애플리케이션을 구축합니다. VPC, 서브넷, 보안 그룹 및 EC2 인스턴스를 생성하고, 이러한 인스턴스에 Kubernetes를 구성하는 과정을 포함합니다.

## 목차
- [프로젝트 구조](#프로젝트-구조)
- [필수 조건](#필수-조건)
- [설치 방법](#설치-방법)
- [사용 방법](#사용-방법)
- [Terraform 모듈](#terraform-모듈)

## 프로젝트 구조

### Terraform
```
.
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── instances/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── rds/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf


```


### Ansible
```
ansible/
├── ansible.cfg
├── hosts.ini
├── playbook.yml
└── roles/
    ├── common/
    │   └── tasks/
    │       └── main.yml
    └── kubernetes/
        └── tasks/
            └── main.yml
```


## 필수 조건
- Terraform v1.0 이상
- Ansible v2.9 이상
- AWS CLI가 적절한 자격 증명으로 구성됨
- EC2 인스턴스에 접근할 수 있는 SSH 키 페어


## 설치 방법

### Terraform 설치
1. Homebrew를 사용하여 Terraform 설치:
    ```sh
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    ```

2. 설치 확인:
    ```sh
    terraform -v
    ```

### AWS CLI 설치
1. Homebrew를 사용하여 AWS CLI 설치:
    ```sh
    brew install awscli
    ```

2. 설치 확인:
    ```sh
    aws --version
    ```

3. AWS CLI 구성:
    ```sh
    aws configure
    ```
   프롬프트에 따라 AWS Access Key, Secret Access Key, 리전 및 출력 형식을 입력합니다.

### Terraform 초기화 및 적용
1. Terraform 초기화:
    ```sh
    terraform init
    ```

2. 구성 검증:
    ```sh
    terraform validate
    ```

3. 인프라 변경 계획:
    ```sh
    terraform plan
    ```

4. 인프라 변경 적용:
    ```sh
    terraform apply
    ```


### Ansible
1. Ansible 설치:
    ```sh
    brew install ansible
    ```

2. 설치 확인:
    ```sh
    ansible --version
    ```

## 구성

### Terraform 모듈
Terraform 구성은 네 가지 모듈로 나뉩니다:
1. **VPC**: VPC, 서브넷 및 관련 리소스를 생성합니다.
2. **보안 그룹**: 인스턴스를 위한 보안 그룹을 구성합니다.
3. **인스턴스**: Kubernetes 마스터 및 워커 노드를 위한 EC2 인스턴스를 생성합니다.
4. **RDS**: DB를 위한 rds를 생성합니다.
