data "tencentcloud_user_info" "info" {}

locals {
  app_id = data.tencentcloud_user_info.info.app_id
}

resource "tencentcloud_cos_bucket" "file_storage" {
  bucket = "bucket-with-cors-${local.app_id}"
  acl    = "private"

  cors_rules {
    allowed_origins = ["*"]
    allowed_methods = ["HEAD", "PUT", "GET"]
    allowed_headers = ["*"]
    max_age_seconds = 300
  }
}
