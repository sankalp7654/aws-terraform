locals {

  aws = {
    aws_profile_name = "default"
    region           = "ap-south-1"
    az_count         = "3"
    az_tags = {
      zone0 = "A"
      zone1 = "B"
      zone2 = "C"
    }
  }

  stack_config = {
    resource_prefix = "awesome"
    name_tag_prefix = "My Awesome Stack"
    environment     = "UAT"
    global_tags = {
      "Stack"      = "awesome-aws-stack"
      "Managed By" = "terraform"
      "Owner"    = "Sankalp Saxena"
    }
  }

  vpc = {
    vpc_config = {
      vpc_cidr_base       = "10.5"
      vpc_end_cidr        = ".0.0/16"
      enable_vpc_flow_log = false
    }
  }


  subnets = {
    subnets_config = {
      public_subnet_cidrs = [".0.0/18", ".64.0/18"]
      public_subnet_name_tag = "${local.stack_config.resource_prefix}-public-subnet"
    }
  }

  jumpbox = {
    instance_count              = "1"
    instance_tags               = ["${local.stack_config.resource_prefix}-internal-jump-box"]
    ami_id                      = ["ami-0cc322bc1d1095aa5"]
    instance_type               = "t3a.medium"
    volume_size                 = 30
    volume_types                = "gp2"
    associate_public_ip         = [false]
    termination_protection      = true
    enable_instances_monitoring = true
  }
}