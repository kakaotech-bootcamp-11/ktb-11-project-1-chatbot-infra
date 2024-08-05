**중요: AWS CLI 구성과 terraform.tfvars 파일 생성이 필요합니다.**

### AWS CLI 구성
```sh
aws configure --profile terraform-user
```
   프롬프트에 따라 AWS Access Key, Secret Access Key, 리전 및 출력 형식을 입력합니다.

### terraform.tfvars 생성하기
```yaml
db_username = "DB 유저네임"
db_password = "DB 패스워드"
   ```

### terraform 실행하기
```sh
terraform apply -var-file="terraform.tfvars"
```

---
## 구성

### Terraform 모듈
Terraform 구성은 네 가지 모듈로 나뉩니다:
1. **VPC**: VPC, 서브넷 및 관련 리소스를 생성합니다.
2. **보안 그룹**: 인스턴스를 위한 보안 그룹을 구성합니다.
3. **인스턴스**: Kubernetes 마스터 및 워커 노드를 위한 EC2 인스턴스를 생성합니다.
4. **RDS**: DB를 위한 rds를 생성합니다.


## 설치 및 실행 방법
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
    aws configure --profile terraform-user
    ```
   프롬프트에 따라 AWS Access Key, Secret Access Key, 리전 및 출력 형식을 입력합니다.


### terraform.tfvars 생성하기
```yaml
db_username = "DB 유저네임"
db_password = "DB 패스워드"
```

### Terraform 초기화 및 실행
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
    terraform apply -var-file="terraform.tfvars"
    ```