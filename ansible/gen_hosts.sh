#!/bin/bash

#========================================================
# Task: Terraform 상태 파일 및 hosts.ini 파일 경로 설정
#========================================================

echo "========================================================"
echo "Task: Terraform 상태 파일 및 hosts.ini 파일 경로 설정"
echo "========================================================"

# Terraform 상태 파일 경로
TFSTATE_FILE="../terraform/terraform.tfstate"

# hosts.ini 파일 경로
HOSTS_INI_FILE="hosts.ini"

# 인스턴스 개수
NUM_WORKERS=3

#========================================================
# 함수: 오류 메시지 출력 및 종료
#========================================================

echo "========================================================"
echo "함수: 오류 메시지 출력 및 종료"
echo "========================================================"

function error_exit {
  echo "Error: $1" >&2
  exit 1
}

#========================================================
# jq 명령어 확인
#========================================================

echo "========================================================"
echo "jq 명령어 확인"
echo "========================================================"

command -v jq >/dev/null 2>&1 || error_exit "jq가 설치되어 있지 않습니다. 설치 후 다시 시도해 주세요."

#========================================================
# Terraform 상태 파일 확인
#========================================================

echo "========================================================"
echo "Terraform 상태 파일 확인"
echo "========================================================"

if [ ! -f "$TFSTATE_FILE" ]; then
  error_exit "Terraform 상태 파일을 찾을 수 없습니다: $TFSTATE_FILE"
fi

# Terraform 상태 파일 읽기
TFSTATE=$(cat "$TFSTATE_FILE")
if [ -z "$TFSTATE" ]; then
  error_exit "Terraform 상태 파일을 읽을 수 없습니다."
fi

#========================================================
# Outputs 섹션에서 master IP 주소 추출
#========================================================

echo "========================================================"
echo "Outputs 섹션에서 master IP 주소 추출"
echo "========================================================"

MASTER_IP=$(echo "$TFSTATE" | jq -r '.outputs.master_public_ip.value')
if [ -z "$MASTER_IP" ]; then
  error_exit "Master IP를 찾을 수 없습니다."
fi

#========================================================
# hosts.ini 파일 작성 시작
#========================================================

echo "========================================================"
echo "hosts.ini 파일 작성 시작"
echo "========================================================"

{
  echo "[masters]"
  echo "master ansible_host=$MASTER_IP"
  echo ""
  echo "[workers]"

  # Worker IPs 추출 및 작성
  for ((i=1; i<=NUM_WORKERS; i++)); do
    WORKER_IP=$(echo "$TFSTATE" | jq -r ".outputs.worker${i}_public_ip.value")
    if [ -z "$WORKER_IP" ]; then
      error_exit "Worker${i} IP를 찾을 수 없습니다."
    fi
    echo "worker$i ansible_host=$WORKER_IP"
  done

  echo ""
  echo "[all:vars]"
  echo "ansible_python_interpreter=/usr/bin/python3"
} > "$HOSTS_INI_FILE"

if [ $? -eq 0 ]; then
  echo "hosts.ini 파일이 성공적으로 생성되었습니다."
else
  error_exit "hosts.ini 파일 생성 중 오류가 발생했습니다."
fi

#========================================================
# Task: Master 인스턴스의 private IP 추출 및 vars.yml에 저장
#========================================================

echo "========================================================"
echo "Task: Master 인스턴스의 private IP 추출 및 vars.yml에 저장"
echo "========================================================"

# Terraform 상태 파일에서 private IP 추출
PRIVATE_IP=$(echo "$TFSTATE" | jq -r '.resources[] | select(.type == "aws_instance" and .name == "ktb_11_chatbot_master") | .instances[0].attributes.private_ip')

# IP 추출 확인
if [ -z "$PRIVATE_IP" ]; then
  error_exit "Master 인스턴스의 Private IP를 찾을 수 없습니다."
fi

# VARS_FILE 경로
VARS_FILE="./roles/kubernetes/vars/main.yml"

# vars.yml 파일에 private IP 작성
echo "master_private_ip: \"$PRIVATE_IP\"" > "$VARS_FILE"

if [ $? -eq 0 ]; then
  echo "Private IP ($PRIVATE_IP)가 $VARS_FILE에 성공적으로 저장되었습니다."
else
  error_exit "$VARS_FILE 파일 생성 중 오류가 발생했습니다."
fi

#========================================================
# 스크립트 종료
#========================================================

echo "========================================================"
echo "모든 작업이 완료되었습니다."
echo "========================================================"

