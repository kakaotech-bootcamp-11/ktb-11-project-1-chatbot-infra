# Kaniko Manifests

이 폴더는 Kubernetes 클러스터에서 Kaniko를 사용하여 컨테이너 이미지를 빌드하기 위한 매니페스트 파일을 포함하고 있습니다.

## Kaniko 소개

Kaniko는 Kubernetes 클러스터 내에서 컨테이너 이미지를 안전하고 효율적으로 빌드할 수 있도록 도와주는 도구입니다. Docker 데몬을 필요로 하지 않아 클라우드 네이티브 환경에서의 이미지 빌드에 적합합니다.

## 실행 순서

Kaniko를 사용하여 이미지를 빌드하고 각 서비스를 실행하려면 다음 순서대로 매니페스트를 적용하십시오:

1. **Kaniko 볼륨**: Kaniko 빌드를 위한 볼륨을 생성합니다.
    ```bash
    kubectl apply -f kaniko-volume.yaml
    ```

2. **Kaniko 시크릿**: 컨테이너 레지스트리에 이미지를 푸시하기 위한 시크릿을 생성합니다.
    ```bash
    kubectl apply -f kaniko-secret.yaml
    ```

3. **각 서비스의 Pod 배포**: 각 서비스에 맞게 다음 매니페스트를 실행합니다.
   - **Backend** 서비스:
     ```bash
     kubectl apply -f backend.yaml
     ```
   - **NLP** 서비스:
     ```bash
     kubectl apply -f nlp.yaml
     ```
   - **Frontend** 서비스:
     ```bash
     kubectl apply -f frontend.yaml
     ```

각 단계가 성공적으로 완료되었는지 확인한 후 다음 단계로 진행하십시오. 모든 매니페스트가 적용되면 각 서비스가 Kubernetes 클러스터에서 실행됩니다.
