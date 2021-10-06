module "vpc" {
  source       = "./vpc"
  aws_vpc_name = "${local.stack_config.resource_prefix}-primary-vpc"
  az_count     = local.aws.az_count
  global_tags  = local.stack_config.global_tags

  vpc_cidr_base            = local.vpc.vpc_config.vpc_cidr_base
  vpc_end_cidr             = local.vpc.vpc_config.vpc_end_cidr
  vpc_instance_tenancy     = "default"
  vpc_enable_dns_support   = "true"
  vpc_enable_dns_hostnames = "true"
  vpc_enable_classiclink   = "false"
}


module "subnets" {
  source                  = "./subnets"
  aws_vpc_id              = module.vpc.aws_vpc_id 
  vpc_cidr_base           = local.vpc.vpc_config.vpc_cidr_base

  public_subnet_cidrs     = zipmap(slice(["zone0", "zone1", "zone2"], 0, length(local.subnets.subnets_config.public_subnet_cidrs)), local.subnets.subnets_config.public_subnet_cidrs)
  public_subnet_name_tags = zipmap(slice(["zone0", "zone1", "zone2"], 0, length(local.subnets.subnets_config.public_subnet_cidrs)), slice([for key, val in local.aws.az_tags : "${local.subnets.subnets_config.public_subnet_name_tag}-zone-${lower("${val}")}"], 0, length(local.subnets.subnets_config.public_subnet_cidrs)))

  aws_azs = slice(local.availability_zones, 0, tonumber(local.aws.az_count))

  global_tags          = local.stack_config.global_tags
}


module "jump-box" {
  source                              = "./ec2"
  global_tags                         = local.stack_config.global_tags
  resource_prefix                     = local.stack_config.resource_prefix
  aws_vpc_id                          = module.vpc.aws_vpc_id 
  subnet_ids                          = ["${module.subnets.public_subnets_ids[0]}"]
  instance_count                      = local.jumpbox.instance_count
  instance_tags                       = local.jumpbox.instance_tags
  volume_type                         = local.jumpbox.volume_types
  volume_size                         = local.jumpbox.volume_size
  ami_id                              = local.jumpbox.ami_id
  instance_type                       = local.jumpbox.instance_type
  termination_protection              = local.jumpbox.termination_protection
  key_pair                            = "${local.stack_config.resource_prefix}-jump-box-key"
  jumpbox_associate_public_ip         = local.jumpbox.associate_public_ip
  jumpbox_enable_instances_monitoring = local.jumpbox.enable_instances_monitoring
}