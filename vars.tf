resource "yandex_kms_symmetric_key" "kms" {
  name              = "kms"
  default_algorithm = "AES_128"
  rotation_period   = "80h"
}

data "yandex_iam_service_account" "sa" {
  name     = "terraform"
}
