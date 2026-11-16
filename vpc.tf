# Create the private address boundary for the project.
resource "aws_vpc" "enterprise" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "enterprise-dc-vpc"
  }
}

# Attach the internet edge used by the public tier.
resource "aws_internet_gateway" "enterprise" {
  vpc_id = aws_vpc.enterprise.id

  tags = {
    Name = "enterprise-dc-igw"
  }
}
