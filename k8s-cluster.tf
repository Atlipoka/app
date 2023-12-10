resource "yandex_kubernetes_cluster" "k8s-regional" {
  name       = "k8s-regional"
  network_id = yandex_vpc_network.network.id
  master {
    version   = "1.27"
    public_ip = true

    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.subnet1.zone
        subnet_id = yandex_vpc_subnet.subnet1.id
      }

      location {
        zone      = yandex_vpc_subnet.subnet2.zone
        subnet_id = yandex_vpc_subnet.subnet2.id
      }

      location {
        zone      = yandex_vpc_subnet.subnet3.zone
        subnet_id = yandex_vpc_subnet.subnet3.id
      }
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "Wednesday"
        start_time = "23:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = data.yandex_iam_service_account.sa.id
  node_service_account_id = data.yandex_iam_service_account.sa.id

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms.id
  }
}
