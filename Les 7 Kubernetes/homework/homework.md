##Установка Kubernetes:
###Загрузка последней версии
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```
###Сделайте двоичный файл kubectl исполняемым
`chmod +x ./kubectl`
###Переместите двоичный файл в директорию из переменной окружения PATH
`sudo mv ./kubectl /usr/local/bin/kubectl`
###Убедитесь, что установлена последняя версия
`kubectl version --client`

##Домашняя работа 
###Переход в своё пространство:
`kubectl config set-context --current --namespace=<your_lastname>`


## 1. Создайте деплоймент `app` на базе образа nginx:1.17 и сервис на порт 80
```
$kubectl apply -f deployment_1.yaml
deployment.apps/app created
```

## 2. Создайте конфиг мап из файла `default.conf` с конфигурацией nginx.
```
$kubectl create configmap config2 --from-file=default.conf
configmap/config2 created
```
Посмотрим как выглядит configmap 'config2' в формате yaml:
```
$ kubectl get configmaps config2 -o yaml
apiVersion: v1
data:
  default.conf: |
    server {
        listen       80 default_server;
        server_name  _;

        default_type text/plain;

        location / {
            return 200 '$hostname request: $request_uri\n';
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2020-11-05T13:20:24Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:default.conf: {}
    manager: kubectl-create
    operation: Update
    time: "2020-11-05T13:20:24Z"
  name: config2
  namespace: alekseevich
  resourceVersion: "43229"
  selfLink: /api/v1/namespaces/alekseevich/configmaps/config2
  uid: 7589a5aa-d90a-4d4e-b3bc-52805f2f6edb

```

## 3. Добавьте в деплоймент монтирование созданного configmap как файл в каталог `/etc/nginx/conf.d`


## 4. Создайте секрет c ключом password
```
$ kubectl create -f secret4.yaml
secret/secret4 created
```
username: admin
password: B7wItYlHeRR1

## 5. Создайте configmap из файла default-secret.conf
```
kubectl create configmap config5 --from-file=default-secret.conf
configmap/config5 created
```

## 6. Создайте копию деплоймента `app` с названием файла appsecret.yaml

## 7. Отредактируйте манифест в файле appsecret.yaml

Необходимо изменить:
  - название деплоймента
  - все метки в полях `label:`
  - монтирование configmap с файлом `default-secret.yaml`

Добавьте монтирование секрета как файл в каталог `/opt`

## 8. Примените манифест в кластер и убедитесь что второе приложение запустилось.

## 9. Повторите действия с копированием сервиса, не забудьте исправить метки в поле `selector` сервиса

После применения манифеста с сервисом убедитесь, что сервис видит приложение. Сделать это можно с помощью команд

```
kubectl get pod -o wide
kubectl get ep
```

ip адреса подов приложения должны совпадать с ip адресами Endpoints в сервисе

##Прочее
###По поводу ответа на вопрос про команду exec для pod в котором несколько контейнеров
Можно при подключении задать имя контейнера к которому нужно подключиться
`kubectl exec -i -t my-pod --container main-app -- /bin/bash`
