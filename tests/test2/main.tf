###
# This test adds the 'CORS Rules' configuration variables
###

terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}

resource "random_string" "s3_rstring" {
  length  = 18
  upper   = false
  special = false
}

module "s3" {
  source = "../../module"

  name = "${random_string.s3_rstring.result}-example-s3-bucket"

  bucket_acl = "bucket-owner-full-control"

  bucket_logging = false

  tags = {
    RightSaid = "Fred"
    LeftSaid  = "George"
  }

  environment = "Development"

  lifecycle_enabled = true

  noncurrent_version_expiration_days = "425"

  noncurrent_version_transition_glacier_days = "60"

  noncurrent_version_transition_ia_days = "30"

  object_expiration_days = "425"

  transition_to_glacier_days = "60"

  transition_to_ia_days = "30"

  versioning = true

  website = true

  website_error = "error.html"

  website_index = "index.html"

  allowed_origins = ["*"]

  allowed_methods = ["PUT", "POST"]

  allowed_headers = ["*"]
  #  Not defining these to ensure it can properly handle undefined variable lists or strings
  #  expose_headers  = ["Accept-Ranges", "Content-Range", "Content-Encoding", "Content-Length"]
  #  max_age_seconds = 3000
}
