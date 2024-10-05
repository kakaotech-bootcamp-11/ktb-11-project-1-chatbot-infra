# README.md

이 README는 클러스터에 Metrics Server를 배포하기 위해 사용되는 각 Kubernetes 매니페스트에 대한 개요와 설명을 제공합니다. 각 매니페스트는 필요한 권한, 서비스 및 구성 설정에 중요한 역할을 합니다. 📘

---

## aggregated-metrics-reader.yaml 📊

**종류**: `ClusterRole`

**목적**: `system:aggregated-metrics-reader`라는 ClusterRole을 정의하여 `metrics.k8s.io` API 그룹에서 파드 메트릭을 읽을 수 있는 권한을 부여합니다. 이는 기본 `view`, `edit`, `admin` 역할에 권한을 집계하여 접근 제어를 쉽게 관리할 수 있게 합니다.

**주요 사항:**

- **API 그룹**: `metrics.k8s.io`에 대한 접근 권한 부여.
- **리소스**: `pods`에 대한 작업 허용.
- **Verbs**: `get`, `list`, `watch` 작업 허용.
- **집계 레이블**: 기존 역할에 권한을 집계하여 권한 관리 간소화.

---

## auth-delegator.yaml 🔑

**종류**: `ClusterRoleBinding`

**목적**: `system:auth-delegator` ClusterRole을 `kube-system` 네임스페이스의 `metrics-server` ServiceAccount에 바인딩합니다. 이를 통해 Metrics Server가 Kubernetes API 서버에 인증 확인을 위임할 수 있습니다.

**주요 사항:**

- **역할 참조**: `system:auth-delegator` ClusterRole.
- **대상**: `metrics-server` ServiceAccount.
- **네임스페이스**: `kube-system`.

---

## auth-reader.yaml 📖

**종류**: `RoleBinding`

**목적**: `metrics-server-auth-reader`라는 RoleBinding을 생성하여 `extension-apiserver-authentication-reader` Role을 `metrics-server` ServiceAccount에 바인딩합니다. 이는 Metrics Server가 확장 API 서버 인증 구성을 읽을 수 있는 권한을 부여합니다.

**주요 사항:**

- **역할 참조**: `extension-apiserver-authentication-reader` Role.
- **대상**: `metrics-server` ServiceAccount.
- **네임스페이스**: `kube-system`.

---

## metrics-server-deployment.yaml 🚀

**종류**: `ServiceAccount` 및 `Deployment`

**목적**: Metrics Server 애플리케이션을 배포하고 필요한 ServiceAccount를 설정합니다.

**ServiceAccount:**

- **이름**: `metrics-server`
- **네임스페이스**: `kube-system`

**Deployment:**

- **이름**: `metrics-server`
- **네임스페이스**: `kube-system`
- **컨테이너**: 특정 구성으로 `metrics-server` 컨테이너 실행.
- **볼륨**: NFS 볼륨과 임시 디렉토리 마운트.
- **보안 컨텍스트**: 사용자 및 그룹 ID `1000`으로 컨테이너 실행.
- **호스트 네트워크**: 노드 리소스에 대한 네트워크 액세스를 위해 활성화.
- **인자들(Arguments)**:

  - `--cert-dir=/nfs_shared/metrics`: 인증서 디렉토리 지정.
  - `--metric-resolution=15s`: 메트릭 수집 주기 설정.
  - `--kubelet-preferred-address-types=InternalIP`: kubelet에 접근하기 위해 내부 IP 사용.
  - `--kubelet-insecure-tls`: kubelet의 TLS 검증 생략.
  - `--secure-port=8443`: 보안 포트 설정.

---

## metrics-apiservice.yaml 🛰️

**종류**: `APIService`

**목적**: Metrics Server API(`v1beta1.metrics.k8s.io`)를 Kubernetes API 집계 레이어에 등록하여 Kubernetes API 서버를 통해 메트릭에 접근할 수 있게 합니다.

**주요 사항:**

- **서비스 참조**: `kube-system` 네임스페이스의 `metrics-server` 서비스.
- **그룹**: `metrics.k8s.io`
- **버전**: `v1beta1`
- **TLS 검증 생략**: `insecureSkipTLSVerify: true`로 설정 (프로덕션 환경에서는 권장되지 않음).
- **우선 순위**: `groupPriorityMinimum`과 `versionPriority`를 `100`으로 설정.

---

## metrics-server-service.yaml 🌐

**종류**: `Service`

**목적**: Metrics Server를 클러스터 내부에서 노출하여 다른 서비스와 구성 요소가 통신할 수 있게 합니다.

**주요 사항:**

- **이름**: `metrics-server`
- **네임스페이스**: `kube-system`
- **포트**:

  - **포트**: `443` (서비스 포트)
  - **타겟 포트**: `https` (컨테이너 포트 이름 `https` 참조)
  - **프로토콜**: `TCP`

- **셀렉터**: 라벨이 `k8s-app: metrics-server`인 파드를 대상으로 함.

---

## resource-reader.yaml 📂

**종류**: `ClusterRole` 및 `ClusterRoleBinding`

**목적**: Metrics Server에 클러스터 전반의 다양한 리소스를 읽을 수 있는 권한을 부여합니다.

**ClusterRole:**

- **이름**: `system:metrics-server`
- **권한**:

  - **API 그룹**: `""` (core), `extensions`
  - **리소스**:

    - 코어: `pods`, `nodes`, `nodes/stats`, `namespaces`
    - 확장: `deployments`

  - **동사(Verbs)**: `get`, `list`, `watch`

**ClusterRoleBinding:**

- **이름**: `system:metrics-server`
- **역할 참조**: `system:metrics-server` ClusterRole에 바인딩.
- **대상**: `kube-system` 네임스페이스의 `metrics-server` ServiceAccount.

---

## metrics-NFS-volume.yaml 🗄️

**종류**: `PersistentVolume` 및 `PersistentVolumeClaim`

**목적**: Metrics Server가 인증서와 같은 데이터를 영구 저장할 수 있도록 NFS 스토리지를 설정합니다.

**PersistentVolume (PV):**

- **이름**: `metrics-pv-volume`
- **라벨**: `type: nfs`
- **스토리지 클래스**: `nfs-storage`
- **용량**: `10Gi`
- **액세스 모드**: `ReadWriteMany` (여러 노드에서 읽기 및 쓰기 가능)
- **NFS 구성**:

  - **경로**: `/nfs_shared/metrics`
  - **서버**: `<master-private-ip>` (마스터 노드의 프라이빗 IP로 대체)

**PersistentVolumeClaim (PVC):**

- **이름**: `metrics-pv-claim`
- **네임스페이스**: `kube-system`
- **스토리지 클래스**: `nfs-storage`
- **액세스 모드**: `ReadWriteMany`
- **리소스 요청**:

  - **스토리지**: `3Gi`

---

# 사용 방법 🛠️

1. **매니페스트 적용**: 각 매니페스트를 올바른 순서로 적용하여 Metrics Server와 그 종속성을 설정합니다.
2. **자리 표시자 교체**: `<master-private-ip>`와 같은 자리 표시자를 실제 값으로 교체하세요.
3. **배포 확인**: 매니페스트를 적용한 후 Metrics Server가 실행 중이고 메트릭을 수집하고 있는지 확인합니다.
4. **메트릭 접근**: 이제 `kubectl top nodes` 및 `kubectl top pods` 명령을 사용하여 리소스 사용량을 확인할 수 있습니다.

# 참고 사항 📝

- **보안 고려 사항**: TLS 검증을 생략하는 것(`--kubelet-insecure-tls` 및 `insecureSkipTLSVerify: true`)은 프로덕션 환경에서는 권장되지 않습니다.
- **NFS 설정**: NFS 서버가 올바르게 구성되고 Kubernetes 노드에서 접근 가능한지 확인하세요.
- **집계 레이블**: `aggregated-metrics-reader.yaml`에서 집계 레이블을 사용하여 기존 역할과 권한을 결합합니다.

---

각 매니페스트의 역할을 이해함으로써 Metrics Server 배포를 더욱 효과적으로 커스터마이징하고 문제를 해결할 수 있습니다. 🚀
