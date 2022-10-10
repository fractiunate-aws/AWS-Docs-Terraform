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
variable "vpc_id" {
  type = string
}
variable "subnet_id" {
  type = string
}
