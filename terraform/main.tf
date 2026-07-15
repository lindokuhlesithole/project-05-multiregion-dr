# Primary: eu-central-1
module "primary_network" {
  source = "./modules/network"
  providers = { aws = aws.primary }
  app_name = var.app_name
}

module "primary_compute" {
  source = "./modules/compute"
  providers = { aws = aws.primary }
  app_name          = var.app_name
  vpc_id            = module.primary_network.vpc_id
  public_subnet_ids = module.primary_network.public_subnet_ids
  private_subnet_ids = module.primary_network.private_subnet_ids
  region            = "eu-central-1"
  task_count        = 1
}

module "primary_database" {
  source = "./modules/database"
  providers = { aws = aws.primary }
  app_name = var.app_name
}

module "primary_storage" {
  source = "./modules/storage"
  providers = { aws = aws.primary }
  app_name  = var.app_name
  region    = "eu-central-1"
  account_id = var.account_id
}

# Secondary: eu-west-1 (Pilot Light)
module "secondary_network" {
  source = "./modules/network"
  providers = { aws = aws.secondary }
  app_name = var.app_name
}

module "secondary_compute" {
  source = "./modules/compute"
  providers = { aws = aws.secondary }
  app_name          = var.app_name
  vpc_id            = module.secondary_network.vpc_id
  public_subnet_ids = module.secondary_network.public_subnet_ids
  private_subnet_ids = module.secondary_network.private_subnet_ids
  region            = "eu-west-1"
  task_count        = 0
}

module "secondary_database" {
  source = "./modules/database"
  providers = { aws = aws.secondary }
  app_name = var.app_name
}

module "secondary_storage" {
  source = "./modules/storage"
  providers = { aws = aws.secondary }
  app_name  = var.app_name
  region    = "eu-west-1"
  account_id = var.account_id
}

# Failover
module "failover" {
  source = "./modules/failover"
  providers = { aws = aws.primary }
  app_name = var.app_name
}
