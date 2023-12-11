resource "yandex_kms_symmetric_key" "kms" {
  name              = "kms"
  default_algorithm = "AES_128"
 #rotation_period   = "8760h"
}
