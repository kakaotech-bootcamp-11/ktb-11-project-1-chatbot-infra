# Jenkins Manifests

이 폴더는 Kubernetes 클러스터에 Jenkins를 배포하기 위한 매니페스트 파일을 포함하고 있습니다.

## Jenkins 소개

Jenkins는 소프트웨어 개발의 빌드, 테스트 및 배포와 관련된 부분을 자동화하여 지속적인 통합(Continuous Integration)과 지속적인 배포(Continuous Delivery)를 가능하게 하는 오픈 소스 자동화 서버입니다.

## 실행 순서

Jenkins를 Kubernetes 클러스터에 배포하려면 다음 순서대로 매니페스트를 적용하십시오:

1. **네임스페이스**: Jenkins 리소스를 위한 별도의 네임스페이스를 생성합니다.
    ```bash
    kubectl apply -f namespace.yaml
    ```

2. **볼륨**: Jenkins 스토리지를 위한 Persistent Volume과 Persistent Volume Claim을 생성합니다.
    ```bash
    kubectl apply -f volume.yaml
    ```

3. **서비스**: 클러스터 내에서 Jenkins를 노출하기 위한 서비스를 설정합니다.
    ```bash
    kubectl apply -f service.yaml
    ```

4. **서비스 어카운트**: Jenkins가 Kubernetes API와 상호 작용할 수 있는 서비스 어카운트를 생성합니다.
    ```bash
    kubectl apply -f serviceAccount.yaml
    ```

5. **디플로이먼트**: Jenkins 인스턴스를 배포합니다.
    ```bash
    kubectl apply -f deployment.yaml
    ```

각 단계를 다음 단계로 진행하기 전에 성공적으로 완료되었는지 확인하십시오. 모든 매니페스트가 적용되면 Jenkins가 Kubernetes 클러스터에서 실행됩니다.

즐거운 빌드 되세요!
