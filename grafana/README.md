# Grafana Manifests

이 폴더에는 Kubernetes 클러스터에서 Grafana를 배포하기 위한 매니페스트 파일들이 포함되어 있습니다.

## 매니페스트 적용 순서

Grafana를 배포하려면 다음 순서대로 매니페스트를 적용하십시오:

1. **Volume**: Grafana Namespace와 데이터를 저장할 PV, PVC를 생성합니다.
    ```bash
    kubectl apply -f grafana-volume.yaml
    ```

2. **Deployment**: Grafana 인스턴스를 배포합니다.
    ```bash
    kubectl apply -f grafana-deployment.yaml
    ```

3. **Service**: Grafana 서비스로 접근할 수 있도록 서비스를 생성합니다.
    ```bash
    kubectl apply -f grafana-service.yaml
    ```

각 매니페스트를 순서대로 적용하면 Grafana가 Kubernetes 클러스터에 배포되고 사용할 준비가 완료됩니다.
