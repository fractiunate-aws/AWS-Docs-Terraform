variable "location" {
  type    = string
  default = "eu-central-1"
}
variable "layer" {
  default = 0
}
variable "environment" {
  type = string
}
variable "main_vpc_cidr" {}
