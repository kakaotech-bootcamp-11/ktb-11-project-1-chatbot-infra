## AWS 인프라 아키텍처 설계

### 구성 요소:

1. **VPC (Virtual Private Cloud):**
    - 프라이빗 네트워크를 생성하여 인스턴스 간 통신을 안전하게 유지합니다.
    - CIDR 블록: `10.0.0.0/16`
    - 이름: `ktb-11-chatbot-vpc`


2. **서브넷:**
    - 각 인스턴스를 배치할 서브넷을 생성합니다.
    - 퍼블릭 서브넷 1: CIDR 블록 `10.0.1.0/24`, 가용 영역 `ap-northeast-2a`
    - 퍼블릭 서브넷 2: CIDR 블록 `10.0.2.0/24`, 가용 영역 `ap-northeast-2c`
    - 프라이빗 서브넷: CIDR 블록 `10.0.3.0/24`, 가용 영역 `ap-northeast-2a`


5. **인터넷 게이트웨이:**
    - VPC가 인터넷과 통신할 수 있도록 인터넷 게이트웨이를 생성하고 VPC에 연결합니다.
    - 이름: `ktb-11-chatbot-igw`


4. **라우팅 테이블:**
    - 퍼블릭 서브넷에 인터넷 트래픽을 전달하기 위한 라우팅 테이블을 생성합니다.
    - 이름: `ktb-11-chatbot-public-rt`


5. **보안 그룹:**
    - 각 인스턴스에 적용할 보안 그룹을 생성합니다.
    - 이름: `ktb-11-chatbot-sg`
    - 인바운드 규칙:
        - SSH 접근 허용 (포트 22)
        - HTTP 접근 허용 (포트 80)
        - HTTPS 접근 허용 (포트 443) - 추후 업데이트(?)
        - update_security_group.tf

            ```bash
            # update_security_group.tf
            resource "aws_security_group_rule" "allow_https" {
              type        = "ingress"
              from_port   = 443
              to_port     = 443
              protocol    = "tcp"
              cidr_blocks = ["0.0.0.0/0"]
              security_group_id = aws_security_group.k8s.id
            }
            ```

        - Kubernetes 클러스터 통신 허용 (포트 6443, 10250, 30000-32767)
    - 아웃바운드 규칙:
        - 모든 트래픽 허용

6. **EC2 인스턴스:**
    - 최소 사양의 EC2 인스턴스를 생성합니다.
    - 인스턴스 타입: `t2.micro` (프리 티어 사용 가능)
    - 운영 체제: Amazon Linux 2023 AMI
    - 태그 이름:
        - 마스터 노드: `ktb-11-chatbot-master`
        - 워커 노드 1: `ktb-11-chatbot-worker1`
        - 워커 노드 2: `ktb-11-chatbot-worker2`
        - 워커 노드 3: `ktb-11-chatbot-worker3`


### 네트워크 구성:

- **VPC:** `10.0.0.0/16`
    - 퍼블릭 서브넷 1: `10.0.1.0/24` (가용 영역: `ap-northeast-2a`)
    - 퍼블릭 서브넷 2: `10.0.2.0/24` (가용 영역: `ap-northeast-2c`)
    - 프라이빗 서브넷: `10.0.3.0/24` (가용 영역: `ap-northeast-2a`)
- **인터넷 게이트웨이:** VPC에 연결
- **라우팅 테이블:** 퍼블릭 서브넷에 인터넷 트래픽 전달

### 보안 구성:

- **보안 그룹 설정:**
    - **SSH (포트 22):** 관리자의 접근을 허용
    - **HTTP (포트 80):** 웹 트래픽을 허용
    - **HTTPS (포트 443):** 보안 웹 트래픽을 허용 → 추후 적용 예정
    - **Kubernetes API 서버 (포트 6443):** 클러스터 간 통신을 허용
    - **Kubelet (포트 10250):** 클러스터 간 통신을 허용
    - **NodePort 서비스 (포트 30000-32767):** 외부 트래픽을 허용

### 인프라 리소스 정의:

- **Terraform으로 정의할 리소스:**
    - VPC
    - 서브넷
    - 인터넷 게이트웨이
    - 라우팅 테이블
    - 보안 그룹
    - EC2 인스턴스 (4개)

**Terraform 코드 구조:**

- **main.tf:**
    - 주요 리소스를 정의합니다 (EC2 인스턴스 포함).
- **providers.tf:**
    - AWS 프로바이더 설정을 정의합니다.
- **variables.tf:**
    - 인프라 구성에 사용할 변수를 정의합니다.
- **outputs.tf:**
    - 필요한 출력값을 정의합니다.
- **vpc.tf:**
    - VPC 및 관련 리소스를 정의합니다.
- **security_groups.tf:**
    - 보안 그룹을 정의합니다.
- **instances.tf:**
    - EC2 인스턴스를 정의합니다.

```bash
.
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── vpc.tf
├── security_groups.tf
├── instances.tf

```