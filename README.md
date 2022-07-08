# AKSTerraformLab

1. variable.tf 파일에서 "resource_group_name_prefix", "agent_count" 를 상황에 맞게 수정한다.

2. Azure Portal 에서 스로리지계정을 만들어야 한다. URL 참고해서 진행한다. 이값들을 provider.tf 에 알맞게 넣으면 된다.
https://docs.microsoft.com/ko-kr/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks#1-configure-your-environment

3. terraform.tfvars 에 appid, password, objectID 등을 넣어 줘야 한다. URL참고해서 진행한다.
https://docs.microsoft.com/ko-kr/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks#1-configure-your-environment
 
4. 본인의 Cloud Shell에서 git clone 으로 terraform 코드를 가지고 간다.
git clone https://github.com/ye52270/AKSTerraformLab

5. 2번과 4번에서 값들을 잘 넣었으면 terraform code 폴더로 이동(cd AKSTerraformLab) 해서 아래의 명령어로 init, plan, apply 해준다
terraform init
terraform plan --var-file=terraform.tfvars
terraform apply --var-file=terraform.tfvars --auto-approve

6. 10정도 기다리면 AKS 가 생성이 된다.

7. AKS 가 생성되면, 포탈의 본인 리소스 그룹에 가서 쿠버네티스 자원의 속성을 보고, 접속을 해 준다.
![image](https://user-images.githubusercontent.com/71998296/177923616-22925b73-b023-4f87-a827-207a2a3942cf.png)
