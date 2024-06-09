resource "random_pet" "file_storage" {
  length = 2
}


data "tencentcloud_user_info" "info" {}

locals {
  app_id = data.tencentcloud_user_info.info.app_id
}

resource "tencentcloud_cos_bucket" "file_storage" {
  bucket = "bucket-with-cors-${local.app_id}"
  acl    = "public-read-write"

  cors_rules {
    allowed_origins = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_headers = ["*"]
    max_age_seconds = 300
    expose_headers  = ["Etag"]
  }
}
