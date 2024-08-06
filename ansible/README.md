# ansible-playbook yml 별로 파일 설명
- install_pkg.yml : vim, git, etc for basic package installing ansible-playbook.yml
- install_kube_pkg.yml : install Docker, Enable Docker service, 
			install kubeadm, kubelet, kubectl, gen default dir, add kube apt-key
			hold version of the kubeadm, kubectl, kubelet
- config.yml : memory swap off, 주석처리 swap partition in /etc/fstab
		iptables configure, 
- master_config.yml : kubeadm init, set kubeconfig, isntall CNI
- worker_config.yml : worker node join the cluster

### Ansible 구조
```
ansible/
├── README.md
├── ansible.cfg
├── gen_hosts.sh
├── hosts.ini
├── playbook.yml
├── roles
│   ├── common
│   │   └── tasks
│   │       ├── config.yml
│   │       └── install_pkg.yml
│   └── kubernetes
│       ├── tasks
│       │   ├── install_kube_pkg.yml
│       │   ├── master_config.yml
│       │   └── worker_config.yml
│       └── vars
│           └── main.yml
└── secrets.yml

```

## 설치 방법
### Ansible 설치
1. Ansible 설치:
    ```sh
    brew install ansible
    ```

2. 설치 확인:
    ```sh
    ansible --version
    ```
## 파일 생성 및 실행 방법 (파일 위치는 상단 구조 참고)
### hosts.ini 생성하기
```yaml
[masters]
master ansible_host=<마스터노드 public ip>

[workers]
worker1 ansible_host=<워커노드1 public ip>
worker2 ansible_host=<워커노드2 public ip>
worker3 ansible_host=<워커노드3 public ip>
```

### secrets.yml 생성하기
```yaml
private_key_file: "<키 파일 경로>"
```

### Ansible 실행
```
ansible-playbook playbook.yml
```

### playbook 내 실행 순서
	install_pkg.yml -> install_kube_pkg.yml -> config.yml -> master_config.yml -> worker_cfg.yml

### gen_hosts.sh
chmod+x 로 실행권한 부여한 후 실행
수행내용 : 자동으로 instances의 public ip를 hosts.ini 파일 내용 작성
수행내용 : .tfstate file에서 master instance의 private ip 값 추출해서 /roles/kubernetes/vars/main.yml에 추가함
