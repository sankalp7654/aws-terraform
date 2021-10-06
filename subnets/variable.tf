variable "vpc_cidr_base" {
  description = "Base CIDR for the VPC"
}

variable "aws_vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet_cidrs" {
  description = "CIDRs for the public subnets"
  type        = map(string)
}


variable "aws_azs" {
  description = "comma separated string of availability zones in order of precedence"
  type        = list(string)
}


variable "public_subnet_tags" {
  description = "Tags to apply to the public subnets"
  default     = {}
}

variable "public_subnet_name_tags" {
  description = "Name tags for the public subnets"
  type        = map(string)
}

variable "global_tags" {
  description = "AWS tags that will be added to all resources managed herein"
  type        = map(string)
}

