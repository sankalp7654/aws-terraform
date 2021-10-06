
# Jumpbox instance for creating a private EKS cluster 
resource "aws_instance" "jump-box" {
  count         = var.instance_count
  ami           = element(var.ami_id, count.index)
  instance_type = var.instance_type

  associate_public_ip_address = element(var.jumpbox_associate_public_ip, count.index)
  subnet_id                   = element(var.subnet_ids, count.index)
  disable_api_termination     = var.termination_protection
  monitoring                  = var.jumpbox_enable_instances_monitoring

  // Uses the existing SSH key
  key_name = var.key_pair

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    encrypted   = false
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = merge(
    {
      "Name" = "${element(var.instance_tags, count.index)}"
    },
    var.global_tags
  )
}