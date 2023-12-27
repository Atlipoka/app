resource "yandex_kubernetes_node_group" "pods_group" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = "worker-nodes"
  version    = "1.27"


  instance_template {
    platform_id = "standard-v3"
    name        = "node-{instance.index}"

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.subnet1.id}"]
    }

    resources {
      memory        = 2
      cores         = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 30
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    auto_scale {
      min     = 2
      max     = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "Wednesday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
}
