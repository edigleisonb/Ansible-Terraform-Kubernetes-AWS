# Ansible-Terraform-Kubernetes-AWS
## DevOps - Ansible - Terraform - Kubernetes - AWS - IaC

**Step 1:. Configure credentials AWS (aws configure).**
```
aws configure
```
**Step 2:. Configure public SSH key in main.tf (Terraform).**
```
ssh-keygen -t rsa -b 4096
```
**Step 3:. Create Vms (Terraform).**
```
terraform init
terraform plan
erraform apply
```
**Step 4:. Configure environment and install application.**
```
ansible-playbook -u ubuntu -i ec2.py playbook.yml
```

**Step 5:. Destroy envirement.**
```
terraform destroy -force
```