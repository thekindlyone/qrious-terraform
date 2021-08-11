variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-west-1"
}


variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}

variable "key_name" {
  type    = string
  default = "ec2_ssh_key"
}
