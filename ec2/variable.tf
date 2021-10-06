variable "aws_vpc_id" {}

variable "ami_id" {
  description = "Ami ID for the jumpbox"
  default     = {}
}

variable "instance_type" {
  description = "The instance type for the jump box"
  default     = {}
}

variable "jump_box_name" {
  description = "The name for the jump box instance"
  default     = {}
}

variable "key_pair" {
  description = "The key-pair to be used to ssh into the jump box instance"
  default     = {}
}

variable "subnet_ids" {
  description = "The subnet id for the jump box instance"
  type        = list(any)
}

variable "instance_count" {
  default = "0"
}

variable "instance_tags" {
  type    = list(string)
  default = ["Jump Box 1", "Jump Box 2"]
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = 30
}

variable "jumpbox_associate_public_ip" {
  description = "Associate the public ips to the instances"
}

variable "resource_prefix" {
  description = "Name of the stack prefix"
}

variable "jumpbox_enable_instances_monitoring" {

}

variable "termination_protection" {

}

variable "global_tags" {
  description = "AWS tags that will be added to all resources managed herein"
  type        = map(string)
}