# Fetch all the AZs in the given regione
data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
  availability_zones         = data.aws_availability_zones.azs.names
}