## Deploy do site de divulgação do Listão 2019

A seguinte infraestrutura foi planejada para a divulgação do Listão do PS 2019:  

![Infra Listão 2019](https://i.imgur.com/EKaqbwd.png)

1. Foi utilizada a integração do GitHub com o Docker Hub para realizar o auto-build das imagens com os arquivos do site.  
2. Para cada branch do repositório, uma imagem é criada no Docker Hub.  
3. Um `Secret`, contendo as credenciais às imagens, é usado para fazer o pull das imagens, como é mostrado no comando abaixo:  
  `$ kubectl create secret docker-registry dockerhub-hiagop --docker-server=https://index.docker.io/v1/ --docker-username=hiagop
  --docker-password=!Zd^...7j --docker-email=hcprata17@gmail.com`

O deploy é feito por meio dos manifestos contidos na pasta [/k8s](https://github.com/hiagop/listao2019/tree/master/k8s):  
   `$ kubectl apply -f listao-master-deploy.yaml`  
que deve retornar algo do tipo:  
   `deployment.apps/listao-master created`  
   `service/listao-master-svc created`
