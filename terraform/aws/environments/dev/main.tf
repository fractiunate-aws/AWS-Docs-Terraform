module "vpc-public-eu-1" {
  source        = "../../modules/vpc-public"
  location      = "eu-central-1"
  environment   = "dev"
  layer         = 0
  main_vpc_cidr = "10.0.0.0/24"
}

module "ec2-lamp-eu-1" {
  source      = "../../modules/ec2-lamp"
  layer       = 0
  environment = "dev"
  location    = "eu-central-1"
  vpc_id      = module.vpc-public-eu-1.vpc_id
  subnet_id   = module.vpc-public-eu-1.public_subnet_ids.0
  depends_on  = [module.vpc-public-eu-1]
}
