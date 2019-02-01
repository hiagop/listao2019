# Listão 2019

## Deploy do site de divulgação do Listão 2019

A seguinte infraestrutura foi planejada para a divulgação do Listão do PS 2019:  

![Infra Listão 2019](https://i.imgur.com/EKaqbwd.png)

1. Foi utilizada a integração do GitHub com o Docker Hub para realizar o auto-build das imagens com os arquivos do site.  
2. Para cada branch do repositório, uma imagem é criada no Docker Hub.  
3. Um `Secret`, contendo as credenciais de acesso às imagens, é usado para fazer o pull das imagens, como é mostrado no comando abaixo:  
  `$ kubectl create secret docker-registry dockerhub-hiagop --docker-server=https://index.docker.io/v1/ --docker-username=hiagop
  --docker-password=!Zd^...7j --docker-email=hcprata17@gmail.com`

Exitem três manifestos para fazermos o deploy: master, counter e em-breve. Cada um utiliza uma tag diferente da imagem, que contém uma versão diferente do site do Listão: a versão final (master), a versão com o contador (counter), e a versão com a mensagem "Em Breve" (em-breve).

O deploy é feito por meio dos manifestos contidos na pasta [k8s](https://github.com/hiagop/listao2019/tree/master/k8s):  
   `$ kubectl apply -f listao-master-deploy.yaml`  
que deve retornar algo do tipo:  
   `deployment.apps/listao-master created`  
   `service/listao-master-svc created`  
   
Este manifesto cria um Deployment, que configura um ReplicaSet, definindo quantos Pods serão criados. Caso ocorra alguma falha em um dos Nodes, a réplica daquele Pod é movida para outro Node. Também é criado um Service, que é usado para expor portas rodando nos Pods, que só seriam liberadas para comunicação interna dos Pods. O mesmo é feito para os outros manifestos (listao-counter-deployment.yaml e listao-breve-deployment.yaml). Isso é feito para que as três versões do site estejam rodando ao mesmo tempo. O que possibilita a rápida mudança do site servido, usando regras de Ingress.  

As configurações usadas pelo nginx nos containers para servir o site são colocadas em um ConfigMap:  
    `$ kubectl create cm -n test nginx-listao-cm --from-file=nginx/`  
    
e são montadas no Pod como visto nesse trecho do manifesto:  
```
                ...  
                  volumeMounts:  
                  - name: nginx-conf  
                    mountPath: /etc/nginx  
                ...  
                volumes:  
                - name: nginx-conf  
                  configMap:  
                    name: nginx-listao-cm  
 ```  
 A pasta que contém essas configurações é [k8s/nginx](https://github.com/hiagop/listao2019/tree/master/k8s/nginx).  
 
 ---
 
 ## Load Balancer  
 
 
 
 
