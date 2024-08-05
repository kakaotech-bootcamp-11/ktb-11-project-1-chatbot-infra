# ansible-playbook yml 별로 파일 설명
- install_pkg.yml : vim, git, etc for basic package installing ansible-playbook.yml
- install_kube_pkg.yml : install Docker, Enable Docker service, 
			install kubeadm, kubelet, kubectl, gen default dir, add kube apt-key
			hold version of the kubeadm, kubectl, kubelet
- config.yml : memory swap off, 주석처리 swap partition in /etc/fstab
		iptables configure, 
- master_config.yml : kubeadm init, set kubeconfig, isntall CNI
- worker_config.yml : worker node join the cluster

## secrets.yml 생성하기
```yaml
private_key_file: "<키 파일 경로>"
```

## Ansible 실행
```
ansible-playbook playbook.yml
```

### 실행 순서
	install_pkg.yml -> install_kube_pkg.yml -> config.yml -> master_config.yml -> worker_cfg.yml




