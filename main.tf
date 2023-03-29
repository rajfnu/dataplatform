provider "aws" {
  region = var.aws_region
}

resource "aws_personalize_campaign" "my_personalize_campaign" {
  name                 = var.aws_personalize_campaign_name
  solution_version_arn = "arn:aws:personalize:<REGION>:<ACCOUNT_ID>:solution/<SOLUTION_NAME>/<SOLUTION_VERSION>"
  min_provisioned_tps  = 1
  campaign_config {
    item_threshold = 5
    campaign_min_provisioned_tps = 1
  }
}

resource "aws_quicksight_account" "my_quicksight_account" {
  name = var.aws_quicksight_account_name
  email = "example@example.com"
}

resource "aws_neptune_db_instance" "my_neptune_db_instance" {
  db_instance_identifier = var.aws_neptune_db_instance_name
  db_instance_class      = "db.t3.medium"
  engine                 = "neptune"
  availability_zone      = "us-west-2a"
  db_subnet_group_name   = "default"
}

resource "aws_glue_job" "my_glue_job" {
  name        = var.aws_glue_job_name
  description = "A job that processes data in S3"
  role_arn    = "arn:aws:iam::123456789012:role/my-role"
  command {
    name          = "glueetl"
    script_location = "s3://my-bucket/glue-script.py"
    python_version  = "3"
  }
  default_arguments = {
    "--job-language": "python"
  }
  execution_property {
    max_concurrent_runs = 1
  }
  connections = ["my-connection"]
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.aws_s3_bucket_name
  acl    = "private"
}