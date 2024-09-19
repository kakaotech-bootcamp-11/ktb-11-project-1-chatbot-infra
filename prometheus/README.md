# Prometheus Manifests

이 폴더에는 Kubernetes 클러스터에서 Prometheus 및 Node Exporter를 배포하기 위한 매니페스트 파일들이 포함되어 있습니다.

## Prometheus 소개

Prometheus는 모니터링과 경고를 위한 오픈 소스 시스템으로, 시계열 데이터베이스에 메트릭을 저장하고 쿼리할 수 있는 기능을 제공합니다. Kubernetes 환경에서의 클러스터 상태 모니터링에 널리 사용됩니다.

## 실행 순서

Prometheus를 배포하려면 다음 순서대로 매니페스트를 적용하십시오:

1. **볼륨**: Prometheus Namespace와 데이터를 저장할 PV, PVC를 생성합니다.
    ```bash
    kubectl apply -f prometheus-volume.yaml
    ```

2. **ConfigMap**: Prometheus의 설정을 정의하는 ConfigMap을 생성합니다.
    ```bash
    kubectl apply -f prometheus-configmap.yaml
    ```

3. **서비스**: Prometheus 및 Node Exporter의 서비스를 생성하여 클러스터 내에서 접근할 수 있도록 설정합니다.
    - **Prometheus 서비스**:
      ```bash
      kubectl apply -f prometheus-service.yaml
      ```
    - **Node Exporter 서비스**:
      ```bash
      kubectl apply -f node-exporter-service.yaml
      ```

4. **ServiceAccount**: Prometheus가 클러스터 내에서 실행되기 위한 ServiceAccount를 생성합니다.
    ```bash
    kubectl apply -f prometheus-serviceaccount.yaml
    ```

5. **ClusterRole 및 ClusterRoleBinding**: Prometheus가 필요한 권한을 부여하기 위한 ClusterRole 및 ClusterRoleBinding을 생성합니다.
    - **ClusterRole**:
      ```bash
      kubectl apply -f prometheus-clusterrole.yaml
      ```
    - **ClusterRoleBinding**:
      ```bash
      kubectl apply -f prometheus-clusterrolebinding.yaml
      ```

6. **배포**: Prometheus 및 Node Exporter를 배포합니다.
    - **Prometheus 배포**:
      ```bash
      kubectl apply -f prometheus-deployment.yaml
      ```
    - **Node Exporter DaemonSet**:
      ```bash
      kubectl apply -f node-exporter-daemonset.yaml
      ```
Kube-state-metrics 배포 순서

1. service-account.yaml

2. cluster-role.yaml

3. cluster-role-binding.yaml

4. deployment.yaml

5. service.yaml
