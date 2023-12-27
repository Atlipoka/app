resource "yandex_resourcemanager_folder_iam_member" "admin-account-iam" {
  folder_id = "b1gjjlp1h6jc8jeaclal"
  role      = "eidtor"
  member    = "serviceAccount:yandex_iam_service_account.sa.id"
}

resource "yandex_iam_service_account" "sa" {
  name        = "terraform"
  description = "Роль для управления рескрсами в k8s"
  folder_id   = "b1gjjlp1h6jc8jeaclal"
}
