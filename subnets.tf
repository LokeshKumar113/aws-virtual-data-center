# Map each subnet to its CIDR, zone, and AWS name.
locals {
  subnets = {
    public_az1  = { cidr = "10.0.1.0/24", az = var.availability_zones[0], name = "enterprise-public-az1" }
    public_az2  = { cidr = "10.0.2.0/24", az = var.availability_zones[1], name = "enterprise-public-az2" }
    private_az1 = { cidr = "10.0.11.0/24", az = var.availability_zones[0], name = "enterprise-private-az1" }
    private_az2 = { cidr = "10.0.12.0/24", az = var.availability_zones[1], name = "enterprise-private-az2" }
  }
}

# Create every subnet from the shared map.
resource "aws_subnet" "enterprise" {
  for_each = local.subnets

  vpc_id            = aws_vpc.enterprise.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = each.value.name
  }
}
