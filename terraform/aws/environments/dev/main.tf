module "sample-env-eu-1" {
  source = "../../modules/sample-env"
  layer = 0
  environment = "dev"
  location = "eu-central-1"
}
