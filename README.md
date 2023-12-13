# Дипломный практикум в Yandex.Cloud

## 1. Подготовка облака для начала работы.

1. S3 бакет, в роли бэкенда и kms ключ для него - ``bucket.tf``,``kms.tf``
2. Настройки провайдера прописаны в ``provider.tf``:
 * Для аутентификации в облаке от имени сервисного аккаунта использовал авторизованный ключ, который хранится в файле ``key.json``.
 * При создании backed для хранения состояния, ключи получием из "outputs.tf", чтоб потом из этого файла получить ``access_key`` и ``secret_key`` при инициализации.
3. Для создания сетей и подсетей - ``network.tf``.
4. Файл создающий сервисный аккаунт ``terraform`` c правами ``editor`` - ``sa.tf``.
 * Небольшое примечание. Я использовал файл ``datasource.tf`` для получения информации об уже созданных ресурсах, например у меня уже был создан сервисный аккаунт ``terraform``, который я использовал на предыдущих заданиях. Поэтому, если  у вас нет аккуанта, то закомментируйте в ``datasource.tf`` строчку с получением данных о сервисном аккаунте.
5. В результате при выполнении комманд ``terraform apply --auto-approve`` или ``terraform destroy --auto-approve`` инфраструктура разворачивается без проблем, результаты:
````
vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ terraform apply --auto-approve
data.yandex_iam_service_account.sa: Reading...
yandex_kms_symmetric_key.kms: Refreshing state... [id=abjcud8geefm39itnnlc]
data.yandex_iam_service_account.sa: Read complete after 0s [id=ajereg9535ct9lmk2cg2]
yandex_iam_service_account_static_access_key.sa-static-key: Refreshing state... [id=aje5gh12r8unha8b5pse]
yandex_storage_bucket.kabaev-bucket: Refreshing state... [id=kabaev-bucket]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet1 will be created
  + resource "yandex_vpc_subnet" "subnet1" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.1.0.0/16",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # yandex_vpc_subnet.subnet2 will be created
  + resource "yandex_vpc_subnet" "subnet2" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.2.0.0/16",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # yandex_vpc_subnet.subnet3 will be created
  + resource "yandex_vpc_subnet" "subnet3" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet3"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.3.0.0/16",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-c"
    }

Plan: 4 to add, 0 to change, 0 to destroy.
yandex_vpc_network.network: Creating...
yandex_vpc_network.network: Creation complete after 1s [id=enpe0ioj2bnk3r267k20]
yandex_vpc_subnet.subnet3: Creating...
yandex_vpc_subnet.subnet1: Creating...
yandex_vpc_subnet.subnet2: Creating...
yandex_vpc_subnet.subnet2: Creation complete after 0s [id=e2llm0rnfen6maqd8u6e]
yandex_vpc_subnet.subnet1: Creation complete after 1s [id=e9b2i3s9keprth3k21cu]
yandex_vpc_subnet.subnet3: Creation complete after 2s [id=b0cqfo838mlalbbaf4se]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

access_key = <sensitive>
secret_key = <sensitive>

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ terraform destroy
data.yandex_iam_service_account.sa: Reading...
yandex_kms_symmetric_key.kms: Refreshing state... [id=abjcud8geefm39itnnlc]
yandex_vpc_network.network: Refreshing state... [id=enpe0ioj2bnk3r267k20]
data.yandex_iam_service_account.sa: Read complete after 1s [id=ajereg9535ct9lmk2cg2]
yandex_iam_service_account_static_access_key.sa-static-key: Refreshing state... [id=aje5gh12r8unha8b5pse]
yandex_vpc_subnet.subnet3: Refreshing state... [id=b0cqfo838mlalbbaf4se]
yandex_vpc_subnet.subnet1: Refreshing state... [id=e9b2i3s9keprth3k21cu]
yandex_vpc_subnet.subnet2: Refreshing state... [id=e2llm0rnfen6maqd8u6e]
yandex_storage_bucket.kabaev-bucket: Refreshing state... [id=kabaev-bucket]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # yandex_iam_service_account_static_access_key.sa-static-key will be destroyed
  - resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
      - access_key         = "YCAJEtZH0pd9yCMvkSfzztUrK" -> null
      - created_at         = "2023-12-13T10:17:43Z" -> null
      - id                 = "aje5gh12r8unha8b5pse" -> null
      - secret_key         = (sensitive value) -> null
      - service_account_id = "ajereg9535ct9lmk2cg2" -> null
    }

  # yandex_kms_symmetric_key.kms will be destroyed
  - resource "yandex_kms_symmetric_key" "kms" {
      - created_at          = "2023-12-13T10:17:43Z" -> null
      - default_algorithm   = "AES_128" -> null
      - deletion_protection = false -> null
      - folder_id           = "b1gjjlp1h6jc8jeaclal" -> null
      - id                  = "abjcud8geefm39itnnlc" -> null
      - labels              = {} -> null
      - name                = "kms" -> null
      - status              = "active" -> null
    }

  # yandex_storage_bucket.kabaev-bucket will be destroyed
  - resource "yandex_storage_bucket" "kabaev-bucket" {
      - access_key            = "YCAJEtZH0pd9yCMvkSfzztUrK" -> null
      - acl                   = "public-read-write" -> null
      - bucket                = "kabaev-bucket" -> null
      - bucket_domain_name    = "kabaev-bucket.storage.yandexcloud.net" -> null
      - default_storage_class = "STANDARD" -> null
      - folder_id             = "b1gjjlp1h6jc8jeaclal" -> null
      - force_destroy         = false -> null
      - id                    = "kabaev-bucket" -> null
      - max_size              = 0 -> null
      - secret_key            = (sensitive value) -> null
      - tags                  = {} -> null

      - anonymous_access_flags {
          - config_read = true -> null
          - list        = true -> null
          - read        = true -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - apply_server_side_encryption_by_default {
                  - kms_master_key_id = "abjcud8geefm39itnnlc" -> null
                  - sse_algorithm     = "aws:kms" -> null
                }
            }
        }

      - versioning {
          - enabled = false -> null
        }
    }

  # yandex_vpc_network.network will be destroyed
  - resource "yandex_vpc_network" "network" {
      - created_at                = "2023-12-13T11:07:33Z" -> null
      - default_security_group_id = "enpcob6e69s1a3qkijt1" -> null
      - folder_id                 = "b1gjjlp1h6jc8jeaclal" -> null
      - id                        = "enpe0ioj2bnk3r267k20" -> null
      - labels                    = {} -> null
      - name                      = "network" -> null
      - subnet_ids                = [
          - "b0cqfo838mlalbbaf4se",
          - "e2llm0rnfen6maqd8u6e",
          - "e9b2i3s9keprth3k21cu",
        ] -> null
    }

  # yandex_vpc_subnet.subnet1 will be destroyed
  - resource "yandex_vpc_subnet" "subnet1" {
      - created_at     = "2023-12-13T11:07:35Z" -> null
      - folder_id      = "b1gjjlp1h6jc8jeaclal" -> null
      - id             = "e9b2i3s9keprth3k21cu" -> null
      - labels         = {} -> null
      - name           = "subnet1" -> null
      - network_id     = "enpe0ioj2bnk3r267k20" -> null
      - v4_cidr_blocks = [
          - "10.1.0.0/16",
        ] -> null
      - v6_cidr_blocks = [] -> null
      - zone           = "ru-central1-a" -> null
    }

  # yandex_vpc_subnet.subnet2 will be destroyed
  - resource "yandex_vpc_subnet" "subnet2" {
      - created_at     = "2023-12-13T11:07:35Z" -> null
      - folder_id      = "b1gjjlp1h6jc8jeaclal" -> null
      - id             = "e2llm0rnfen6maqd8u6e" -> null
      - labels         = {} -> null
      - name           = "subnet2" -> null
      - network_id     = "enpe0ioj2bnk3r267k20" -> null
      - v4_cidr_blocks = [
          - "10.2.0.0/16",
        ] -> null
      - v6_cidr_blocks = [] -> null
      - zone           = "ru-central1-b" -> null
    }

  # yandex_vpc_subnet.subnet3 will be destroyed
  - resource "yandex_vpc_subnet" "subnet3" {
      - created_at     = "2023-12-13T11:07:36Z" -> null
      - folder_id      = "b1gjjlp1h6jc8jeaclal" -> null
      - id             = "b0cqfo838mlalbbaf4se" -> null
      - labels         = {} -> null
      - name           = "subnet3" -> null
      - network_id     = "enpe0ioj2bnk3r267k20" -> null
      - v4_cidr_blocks = [
          - "10.3.0.0/16",
        ] -> null
      - v6_cidr_blocks = [] -> null
      - zone           = "ru-central1-c" -> null
    }

Plan: 0 to add, 0 to change, 7 to destroy.

Changes to Outputs:
  - access_key = (sensitive value) -> null
  - secret_key = (sensitive value) -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

````

## 2. Создание Kubernetes кластера

1. Использовал альтернативный вариант создания k8s кластера. Файл создающий региональный кластер размещенный в 3-х разных подсетях - ``k8s-cluster.tf``, ключ создавали в предыдущем разделе, см Подготовка облака для начала работы. п2.
2. Группа нод для k8s с автоматическим маштабированием - ``k8s-nodes.tf``.
3. После создания кластера в вебе получаем информацию как загрузить конфиг кластера, пример комманды ``yc managed-kubernetes cluster get-credentials --id catub9ieiqirticm8ps7 --external
``. Проверяем работу кластера:
````
vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ kubectl get all -A
NAMESPACE     NAME                                      READY   STATUS    RESTARTS   AGE
kube-system   pod/coredns-67964c577c-dcm4v              1/1     Running   0          95m
kube-system   pod/coredns-67964c577c-ml9x8              1/1     Running   0          99m
kube-system   pod/ip-masq-agent-2rb4k                   1/1     Running   0          96m
kube-system   pod/ip-masq-agent-2vstm                   1/1     Running   0          96m
kube-system   pod/kube-dns-autoscaler-bd7cc5977-b7fhn   1/1     Running   0          99m
kube-system   pod/kube-proxy-8m5gl                      1/1     Running   0          96m
kube-system   pod/kube-proxy-k89xt                      1/1     Running   0          96m
kube-system   pod/metrics-server-6f485d9c99-mp9k9       2/2     Running   0          95m
kube-system   pod/npd-v0.8.0-8rg7p                      1/1     Running   0          96m
kube-system   pod/npd-v0.8.0-zdft8                      1/1     Running   0          96m
kube-system   pod/yc-disk-csi-node-v2-972sb             6/6     Running   0          96m
kube-system   pod/yc-disk-csi-node-v2-sckx4             6/6     Running   0          96m

NAMESPACE     NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes       ClusterIP   10.96.128.1     <none>        443/TCP                  99m
kube-system   service/kube-dns         ClusterIP   10.96.128.2     <none>        53/UDP,53/TCP,9153/TCP   99m
kube-system   service/metrics-server   ClusterIP   10.96.248.189   <none>        443/TCP                  99m

NAMESPACE     NAME                                            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                                                                        AGE
kube-system   daemonset.apps/ip-masq-agent                    2         2         2       2            2           beta.kubernetes.io/os=linux,node.kubernetes.io/masq-agent-ds-ready=true              99m
kube-system   daemonset.apps/kube-proxy                       2         2         2       2            2           kubernetes.io/os=linux,node.kubernetes.io/kube-proxy-ds-ready=true                   99m
kube-system   daemonset.apps/npd-v0.8.0                       2         2         2       2            2           beta.kubernetes.io/os=linux,node.kubernetes.io/node-problem-detector-ds-ready=true   99m
kube-system   daemonset.apps/nvidia-device-plugin-daemonset   0         0         0       0            0           beta.kubernetes.io/os=linux,node.kubernetes.io/nvidia-device-plugin-ds-ready=true    99m
kube-system   daemonset.apps/yc-disk-csi-node                 0         0         0       0            0           <none>                                                                               99m
kube-system   daemonset.apps/yc-disk-csi-node-v2              2         2         2       2            2           yandex.cloud/pci-topology=k8s                                                        99m

NAMESPACE     NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns               2/2     2            2           99m
kube-system   deployment.apps/kube-dns-autoscaler   1/1     1            1           99m
kube-system   deployment.apps/metrics-server        1/1     1            1           99m

NAMESPACE     NAME                                            DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-67964c577c              2         2         2       99m
kube-system   replicaset.apps/kube-dns-autoscaler-bd7cc5977   1         1         1       99m
kube-system   replicaset.apps/metrics-server-54cb698b7f       0         0         0       99m
kube-system   replicaset.apps/metrics-server-6f485d9c99       1         1         1       95m
````

## 3. Создание тестового приложения

1. Для создания собственного приложения был использован nginx, который по определенному api будет отдавать статическую информацию и доступ к монитоингу кластера k8s. Сборка образа с необходимыми файлами и конфигом - ``nginx.Dockerfile`` и ``default.conf``
2. Yandex registry, для хранения собранных образов - ``registry.tf``.
3. Для создания приложения и системы мониторинга в k8s ипользовал Helm, созданы два репозитория ``application/`` - для приложения и ``kube-prometheus-stack/`` - для настройки мониторинга (взято по ссылке https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack).
4. Создаем регистри, собиреам необходимый образ и грузим его в регистри, создаем с помощью Helm два неймспейса application и monitoring, деплоим в эти неймспейсы необходимые объекты и проверям работу нашего приложения через веб:
````
vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ cat key.json | sudo docker login \
> --username json_key \
> --password-stdin \
> cr.yandex/crpklmpvk1ob1hk3mvj7
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ sudo docker build -f nginx.Dockerfile --no-cache -t cr.yandex/crpklmpvk1ob1hk3mvj7/app:1.0.0 .
[+] Building 13.3s (10/10) FINISHED                                                                                                                                             docker:default
 => [internal] load build definition from nginx.Dockerfile                                                                                                                                0.7s
 => => transferring dockerfile: 307B                                                                                                                                                      0.2s
 => [internal] load .dockerignore                                                                                                                                                         0.5s
 => => transferring context: 2B                                                                                                                                                           0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                                                                                           2.5s
 => CACHED [1/5] FROM docker.io/library/nginx:latest@sha256:10d1f5b58f74683ad34eb29287e07dab1e90f10af243f151bb50aa5dbb4d62ee                                                              0.1s
 => [internal] load build context                                                                                                                                                         0.2s
 => => transferring context: 2.84kB                                                                                                                                                       0.1s
 => [2/5] COPY ./pages/intro/intro.html /var/www/html/intro/intro.html                                                                                                                    2.3s
 => [3/5] COPY ./pages/describe/desc.html /var/www/html/describe/desc.html                                                                                                                1.5s
 => [4/5] COPY ./pages/image/dev.jpg /var/www/html/image/dev.jpg                                                                                                                          1.6s
 => [5/5] COPY ./default.conf /etc/nginx/conf.d/default.conf                                                                                                                              1.4s
 => exporting to image                                                                                                                                                                    1.4s
 => => exporting layers                                                                                                                                                                   1.3s
 => => writing image sha256:c44340336368d17173e5dda8812c178ff534bd28c94fa2f5bb07b2edaaacb302                                                                                              0.1s
 => => naming to cr.yandex/crpklmpvk1ob1hk3mvj7/app:1.0.0                                                                                                                                 0.0s

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ sudo docker push cr.yandex/crpklmpvk1ob1hk3mvj7/app:1.0.0
The push refers to repository [cr.yandex/crpklmpvk1ob1hk3mvj7/app]
7171f9e16b2c: Pushed
6a527c5ffde1: Pushed
e19910c6ccf6: Pushed
81b60c681371: Pushed
0d0e9c83b6f7: Pushed
cddc309885a2: Pushed
c2d3ab485d1b: Pushed
66283570f41b: Pushed
f5525891d9e9: Pushed
8ae474e0cc8f: Pushed
92770f546e06: Pushed
1.0.0: digest: sha256:fb7184a7f213574e57b3e551e04afdc029e13bdf143be7e8833f3f71552836cb size: 2610

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ helm upgrade --install monitoring  --namespace monitoring --create-namespace ./kube-prometheus-stack/
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/vagrant/.kube/config
Release "monitoring" does not exist. Installing it now.
NAME: monitoring
LAST DEPLOYED: Mon Dec 11 13:47:36 2023
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
NOTES:
kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=monitoring"

Visit https://github.com/prometheus-operator/kube-prometheus for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.
vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ helm upgrade --install application  --namespace application --create-namespace ./application/
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/vagrant/.kube/config
Release "application" does not exist. Installing it now.
NAME: application
LAST DEPLOYED: Mon Dec 11 13:59:10 2023
NAMESPACE: application
STATUS: deployed
REVISION: 1
TEST SUITE: None

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ kubectl get all -n application
NAME                         READY   STATUS    RESTARTS   AGE
pod/nginx-85fb4567d6-2fgpv   1/1     Running   0          66s
pod/nginx-85fb4567d6-g98nc   1/1     Running   0          63s

NAME                TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)                      AGE
service/nginx-svc   LoadBalancer   10.96.190.21   158.160.135.144   80:30731/TCP,443:30619/TCP   67s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   2/2     2            2           67s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-85fb4567d6   2         2         2       67s

vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ kubectl get all -n monitoring
NAME                                                         READY   STATUS    RESTARTS   AGE
pod/alertmanager-monitoring-kube-prometheus-alertmanager-0   2/2     Running   0          26m
pod/monitoring-grafana-844f89c759-sw27x                      3/3     Running   0          26m
pod/monitoring-kube-prometheus-operator-5fbb66b4b-mjhp7      1/1     Running   0          26m
pod/monitoring-kube-state-metrics-74f4d8858f-v99pl           1/1     Running   0          26m
pod/monitoring-prometheus-node-exporter-b9npp                1/1     Running   0          26m
pod/monitoring-prometheus-node-exporter-p9fxj                1/1     Running   0          26m
pod/prometheus-monitoring-kube-prometheus-prometheus-0       2/2     Running   0          26m

NAME                                              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
service/alertmanager-operated                     ClusterIP   None            <none>        9093/TCP,9094/TCP,9094/UDP   26m
service/monitoring-grafana                        ClusterIP   10.96.204.15    <none>        3000/TCP,9094/TCP,9094/UDP   26m
service/monitoring-kube-prometheus-alertmanager   ClusterIP   10.96.174.148   <none>        9093/TCP,8080/TCP            26m
service/monitoring-kube-prometheus-operator       ClusterIP   10.96.204.193   <none>        443/TCP                      26m
service/monitoring-kube-prometheus-prometheus     ClusterIP   10.96.234.107   <none>        9090/TCP,8080/TCP            26m
service/monitoring-kube-state-metrics             ClusterIP   10.96.255.34    <none>        8080/TCP                     26m
service/monitoring-prometheus-node-exporter       ClusterIP   10.96.249.245   <none>        9100/TCP                     26m
service/prometheus-operated                       ClusterIP   None            <none>        9090/TCP                     26m

NAME                                                 DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/monitoring-prometheus-node-exporter   2         2         2       2            2           kubernetes.io/os=linux   26m

NAME                                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/monitoring-grafana                    1/1     1            1           26m
deployment.apps/monitoring-kube-prometheus-operator   1/1     1            1           26m
deployment.apps/monitoring-kube-state-metrics         1/1     1            1           26m

NAME                                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/monitoring-grafana-844f89c759                   1         1         1       26m
replicaset.apps/monitoring-kube-prometheus-operator-5fbb66b4b   1         1         1       26m
replicaset.apps/monitoring-kube-state-metrics-74f4d8858f        1         1         1       26m

NAME                                                                    READY   AGE
statefulset.apps/alertmanager-monitoring-kube-prometheus-alertmanager   1/1     26m
statefulset.apps/prometheus-monitoring-kube-prometheus-prometheus       1/1     26m
````
![intro](https://github.com/Atlipoka/app/blob/main/screen/intro.png)
![describe](https://github.com/Atlipoka/app/blob/main/screen/describe.png)
![image](https://github.com/Atlipoka/app/blob/main/screen/image.png)
![grafana1](https://github.com/Atlipoka/app/blob/main/screen/grafana1.png)
![grafana2](https://github.com/Atlipoka/app/blob/main/screen/grafana2.png)
![grafana3](https://github.com/Atlipoka/app/blob/main/screen/grafana3.png)
