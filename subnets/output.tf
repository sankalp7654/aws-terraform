
output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id 
}

output "public_subnets_cidrs" {
  value = aws_subnet.public_subnets.*.cidr_block 
}
