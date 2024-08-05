## terraform.tfvars 생성하기
```yaml
db_username = "DB 유저네임"
db_password = "DB 패스워드"
```
## Terraform 실행
```
terraform apply -var-file="terraform.tfvars"
```