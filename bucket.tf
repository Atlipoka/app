resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = data.yandex_iam_service_account.sa.id
}

resource "yandex_storage_bucket" "kabaev-bucket" {
  bucket     = "kabaev-bucket"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl        = "public-read-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.kms.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
