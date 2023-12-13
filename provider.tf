terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "kabaev-bucket"
    region                      = "ru-central1"
    key                         = "./terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone                     = "ru-central1-a"
  service_account_key_file = file("./key.json")
  cloud_id                 = "b1g9tskfs4f4itprsns9"
  folder_id                = "b1gjjlp1h6jc8jeaclal"
  #token     = "$YC_TOKEN"
}
