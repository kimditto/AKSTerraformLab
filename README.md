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

7. AKS 가 생성되면, 포탈의 본인 리소스 그룹에 가서 쿠버네티스 자원의 속성을 보고, Cloud Shell 에서 명령어를 실행해 준다

![image](https://user-images.githubusercontent.com/71998296/177923616-22925b73-b023-4f87-a827-207a2a3942cf.png)

8. Grafana 와 Prometheus 를 설치한다. 아래 명령어를 실행한다. (아래 명령어로 두 개 한번에 설치 가능)

helm repo update

helm repo list

kubectl create ns prometheus

helm install prometheus prometheus-community/kube-prometheus-stack -n prometheus

kubectl get all -n prometheus

9. 생성한 grafana 와 prometheus 는 ClouterIP로 기본 설정이 되기 때문에 외부에서 접속을 위해 아래 명령어로 각각 서비스를 수정해 준다.

kubectl edit svc -n prometheus prometheus-grafana

type: Cluster IP 를 type: NodePort 로 수정해준다.



kubectl edit svc prometheus-kube-prometheus-prometheus -n prometheus

type: Cluster IP 를 type: NodePort 로 수정해준다.

10. kubectl get svc -n prometheus 명령어로 NodePort 를 확인한다.

예를 들어 PORT(S) 가 80:32463 이면 32463으로 접속해야 한다.

11. http://NodeExterlanIP:prometheus-kube-prometheus-prometheus포트  로 접속하면 prometheus 로 접속된다.

12. http://NodeExterlanIP:prometheus-grafana포트 로 접속하면 grafana 로 접속된다.

13. grafana 의 최초 ID,Pwd 는 admin, prom-operator 이다. 아래의 명령어를 임력하면 id 와 pwd 확인을 할 수 있다.

kubectl get secret -n prometheus prometheus-grafana -o=jsonpath='{.data.admin-user}' |base64 -d

kubectl get secret -n prometheus prometheus-grafana -o=jsonpath='{.data.admin-password}' |base64 -d

14. grafa 에서 azure monitor 를 data source 에 추가해줘야 한다. 아래 명령어를 확인해 준다.

az ad sp create-for-rbac --role="Monitoring Reader" --scopes="/subscriptions/구독ID/resourceGroups/리소스그룹명"

15. 아래URL을 참고해서 grafana 모니터링을 확인해준다.

https://shailender-choudhary.medium.com/monitor-azure-kubernetes-service-aks-with-prometheus-and-grafana-8e2fe64d1314

* 외부 노출을 하지 말아 주세요.


