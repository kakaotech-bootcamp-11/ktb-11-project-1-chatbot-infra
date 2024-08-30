## Docker 빌드 명령어

 `backend`, `frontend`, `ai` 구성 요소에 대한 Docker 이미지를 빌드하고 푸시하는 방법


---

### Backend

#### 1. Gradle을 사용하여 애플리케이션 빌드:

```bash
./gradlew clean build
```

#### 2. Docker 이미지 빌드 및 푸시:

```bash
docker buildx build --platform linux/amd64 -t ktb11chatbot/ktb-11-project-1-chatbot-be:latest --push .
```

---

### Frontend

#### 1. Docker 이미지 빌드 및 푸시:

```bash
docker buildx build --platform linux/amd64 \
  --build-arg NEXT_PUBLIC_API_URL=http://ktb-chatbot.shop/api \
  --build-arg NEXT_PUBLIC_IMAGE_URL=http://openweathermap.org \
  -t ktb11chatbot/ktb-11-project-1-chatbot-fe:latest --push .
```

---

### AI

#### 1. Docker 이미지 빌드 및 푸시:

```bash
docker buildx build --platform linux/amd64 -t ktb11chatbot/ktb-11-project-1-chatbot-nlp:latest --push .
```

---

### docker buildx 사용 이유
이는 로컬 개발 환경과 AWS 인스턴스 간의 아키텍처 차이를 해결하고, 다양한 환경에서 호환 가능한 이미지를 배포하기 위함입니다.

현 docker buildx 명령어는 linux/amd64 아키텍처로 이미지를 빌드하기 위해 사용됩니다.