# Create the route table used only by public subnets.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.enterprise.id

  tags = {
    Name = "enterprise-public-rt"
  }
}

# Send public IPv4 destinations to the internet gateway.
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.enterprise.id
}

# Associate only the two public subnets.
resource "aws_route_table_association" "public" {
  for_each = {
    for key, subnet in aws_subnet.enterprise : key => subnet
    if startswith(key, "public")
  }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
