variable "aws_region" {
  type    = string
  default = "ap-southeast-2"
}

variable "aws_personalize_campaign_name" {
  type    = string
  default = "my-personalize-campaign"
}

variable "aws_quicksight_account_name" {
  type    = string
  default = "my-quicksight-account"
}

variable "aws_neptune_db_instance_name" {
  type    = string
  default = "my-neptune-db-instance"
}

variable "aws_glue_job_name" {
  type    = string
  default = "my-glue-job"
}

variable "aws_s3_bucket_name" {
  type    = string
  default = "my-s3-bucket"
}