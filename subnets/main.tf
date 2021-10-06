resource "aws_subnet" "public_subnets" {
  count             = "${length(var.public_subnet_cidrs)}" 
  vpc_id            = var.aws_vpc_id
  cidr_block        = "${var.vpc_cidr_base}${var.public_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(var.aws_azs, count.index) 
  tags = merge(
    var.global_tags,
    {
      "Name" = "${var.public_subnet_name_tags[format("zone%d", count.index)]}"
    }
  )
}