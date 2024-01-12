resource "yandex_compute_instance" "jenkins-master" {
  name        = "jenkins-master"
  platform_id = "standard-v3"
  hostname    = "jenkins-master"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8o6khjbdv3f1suqf69"
      size     = 8
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
