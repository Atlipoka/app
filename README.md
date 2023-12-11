# Дипломный практикум в Yandex.Cloud

## 1. Подготовка облака для начала работы.

1. Файл создающий сервисный аккаунт ``terraform`` c правами ``editor`` - ``sa.tf``
2. S3 бакет, в роли бэкенда и kms ключ для него - ``bucket.tf``,``kms.tf``
3. Для создания сетей и подсетей - ``network.tf``
4. В ``provider.tf`` указаны аутентификационные данные для доступа к облаку, папке в облаке, а так-же сервиснуму аккаунту, от имени которого будем производить действия в облаке. Прошу заменить, что для аутентификации я использовал авторизованный ключ, который хранится в файле ``key.json``. Это было сделано для упрощения процесса развертывания инфраструктуры, чтоб постоянно не запрашивать IAM токены, которые имеют срок жизни, по моему, 12 часов...кароче не более суток.
5. Небольшое примечание. Я использовал файл ``vars.tf`` для получения информации об уже созданных ресурсах, например у меня уже был создан сервисный аккаунт ``terraform``, который я использовал на предыдущих заданиях. Поэтому, если  у вас нет аккуанта, то добавьте файл ``vars.tf`` в ``.terraformignore`` или закомментируйте в нем строчку с получением данных о сервисном аккаунте.
6. В результате при выполнении комманд ``terraform apply --auto-approve`` или ``terraform destroy --auto-approve`` инфраструктура разворачивается без проблем, результаты:
````
vagrant@vagrant:~/Netology_homeworks/Cloud/Diploma$ terraform apply --auto-approve
data.yandex_iam_service_account.sa: Reading...
data.yandex_iam_service_account.sa: Read complete after 1s [id=ajereg9535ct9lmk2cg2]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_container_registry.default will be created
  + resource "yandex_container_registry" "default" {
      + created_at = (known after apply)
      + folder_id  = "b1gjjlp1h6jc8jeaclal"
      + id         = (known after apply)
      + name       = "registry"
      + status     = (known after apply)
    }

  # yandex_iam_service_account.sa will be created
  + resource "yandex_iam_service_account" "sa" {
      + created_at  = (known after apply)
      + description = "Роль для управления рескрсами в k8s"
      + folder_id   = "b1gjjlp1h6jc8jeaclal"
      + id          = (known after apply)
      + name        = "terraform"
    }

  # yandex_iam_service_account_static_access_key.sa-static-key will be created
  + resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
      + access_key           = (known after apply)
      + created_at           = (known after apply)
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = "ajereg9535ct9lmk2cg2"
    }

  # yandex_kms_symmetric_key.kms will be created
  + resource "yandex_kms_symmetric_key" "kms" {
      + created_at          = (known after apply)
      + default_algorithm   = "AES_128"
      + deletion_protection = false
      + folder_id           = (known after apply)
      + id                  = (known after apply)
      + name                = "kms"
      + rotated_at          = (known after apply)
      + status              = (known after apply)
    }

  # yandex_kubernetes_cluster.k8s-regional will be created
  + resource "yandex_kubernetes_cluster" "k8s-regional" {
      + cluster_ipv4_range       = (known after apply)
      + cluster_ipv6_range       = (known after apply)
      + created_at               = (known after apply)
      + description              = (known after apply)
      + folder_id                = (known after apply)
      + health                   = (known after apply)
      + id                       = (known after apply)
      + labels                   = (known after apply)
      + log_group_id             = (known after apply)
      + name                     = "k8s-regional"
      + network_id               = (known after apply)
      + node_ipv4_cidr_mask_size = 24
      + node_service_account_id  = "ajereg9535ct9lmk2cg2"
      + release_channel          = (known after apply)
      + service_account_id       = "ajereg9535ct9lmk2cg2"
      + service_ipv4_range       = (known after apply)
      + service_ipv6_range       = (known after apply)
      + status                   = (known after apply)

      + kms_provider {
          + key_id = (known after apply)
        }

      + master {
          + cluster_ca_certificate = (known after apply)
          + etcd_cluster_size      = (known after apply)
          + external_v4_address    = (known after apply)
          + external_v4_endpoint   = (known after apply)
          + external_v6_endpoint   = (known after apply)
          + internal_v4_address    = (known after apply)
          + internal_v4_endpoint   = (known after apply)
          + public_ip              = true
          + version                = "1.27"
          + version_info           = (known after apply)

          + maintenance_policy {
              + auto_upgrade = true

              + maintenance_window {
                  + day        = "Wednesday"
                  + duration   = "3h"
                  + start_time = "23:00"
                }
            }

          + regional {
              + region = "ru-central1"

              + location {
                  + subnet_id = (known after apply)
                  + zone      = "ru-central1-a"
                }
              + location {
                  + subnet_id = (known after apply)
                  + zone      = "ru-central1-b"
                }
              + location {
                  + subnet_id = (known after apply)
                  + zone      = "ru-central1-c"
                }
            }
        }
    }

  # yandex_kubernetes_node_group.pods_group will be created
  + resource "yandex_kubernetes_node_group" "pods_group" {
      + cluster_id        = (known after apply)
      + created_at        = (known after apply)
      + description       = (known after apply)
      + id                = (known after apply)
      + instance_group_id = (known after apply)
      + labels            = (known after apply)
      + name              = "netology"
      + status            = (known after apply)
      + version           = "1.27"
      + version_info      = (known after apply)

      + allocation_policy {
          + location {
              + subnet_id = (known after apply)
              + zone      = "ru-central1-a"
            }
        }

      + instance_template {
          + metadata                  = {
              + "ssh-keys" = <<-EOT
                    ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC55kDGsJTONGl4TJ8i4Jskl7L15+8PPqT72sLe5DdMT8xW6oB6tnhU3t1GJxmgyJ/aW3ZciT12AVovQHq2PagLqtYuSqaWAlPG1S3JguQENHEibeqchY8CQxwCybcteNAcKF5/UtLkypddk7YYnAm42gjSna2gfvGk2bwe+fODfhYQqmfO0VsLm48nJDn+t3weNt7cBkc6VGlU77K5DLt7TkmDd95v7La0cmmZC2VMpEGPG7MqGJ1hyuAeXW0NopREFO1EuuwMajtC8wjK5ewXL28uXYYl+gIMzFp7Z6w7FtZhR6y9I9PQBsOrvrEdKR1hYOxA2clf2L5d3e3j/Enm5BBESLH0gbWJ7Douf+Mm89CHKJp0SHISxq0EMv4RsMQIYHYfjyl3Uq22dXyysBqOUOeIDJ8PGRzRaALXa9XFRX3K4BxLgd/kvHGGM0t0HHb4SQKelTUvbHtFWtDIC+tp9Q8MejWApr/9jXCCEn2AWatn0LWmnRtKUJpTqcazlU= vagrant@vagrant
                EOT
            }
          + nat                       = (known after apply)
          + network_acceleration_type = (known after apply)
          + platform_id               = "standard-v3"

          + boot_disk {
              + size = 30
              + type = "network-hdd"
            }

          + container_runtime {
              + type = "containerd"
            }

          + network_interface {
              + ipv4       = true
              + ipv6       = (known after apply)
              + nat        = true
              + subnet_ids = (known after apply)
            }

          + resources {
              + core_fraction = 20
              + cores         = 2
              + gpus          = 0
              + memory        = 2
            }

          + scheduling_policy {
              + preemptible = true
            }
        }

      + maintenance_policy {
          + auto_repair  = true
          + auto_upgrade = true

          + maintenance_window {
              + day        = "Wednesday"
              + duration   = "3h"
              + start_time = "15:00"
            }
        }

      + scale_policy {
          + auto_scale {
              + initial = 3
              + max     = 6
              + min     = 2
            }
        }
    }

  # yandex_resourcemanager_folder_iam_member.admin-account-iam will be created
  + resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
      + folder_id = "b1gjjlp1h6jc8jeaclal"
      + id        = (known after apply)
      + member    = "serviceAccount:yandex_iam_service_account.sa.id"
      + role      = "eidtor"
    }

  # yandex_storage_bucket.kabaev-bucket will be created
  + resource "yandex_storage_bucket" "kabaev-bucket" {
      + access_key            = (known after apply)
      + acl                   = "public-read-write"
      + bucket                = "kabaev-bucket"
      + bucket_domain_name    = (known after apply)
      + default_storage_class = (known after apply)
      + folder_id             = (known after apply)
      + force_destroy         = false
      + id                    = (known after apply)
      + secret_key            = (sensitive value)
      + website_domain        = (known after apply)
      + website_endpoint      = (known after apply)

      + server_side_encryption_configuration {
          + rule {
              + apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  + sse_algorithm     = "aws:kms"
                }
            }
        }
    }

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

Plan: 12 to add, 0 to change, 0 to destroy.
yandex_vpc_network.network: Creating...
yandex_iam_service_account_static_access_key.sa-static-key: Creating...
yandex_kms_symmetric_key.kms: Creating...
yandex_iam_service_account.sa: Creating...
yandex_resourcemanager_folder_iam_member.admin-account-iam: Creating...
yandex_container_registry.default: Creating...

````

## 2. Создание Kubernetes кластера
