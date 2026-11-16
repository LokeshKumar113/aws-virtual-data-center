# Represent the public web-tier traffic policy.
resource "aws_security_group" "web" {
  name        = "enterprise-web-sg"
  description = "Controls public HTTP access to the enterprise web tier."
  vpc_id      = aws_vpc.enterprise.id

  tags = {
    Name = "enterprise-web-sg"
  }
}

# Represent the private application-tier traffic policy.
resource "aws_security_group" "app" {
  name        = "enterprise-app-sg"
  description = "Allows application traffic only from the enterprise web tier."
  vpc_id      = aws_vpc.enterprise.id

  tags = {
    Name = "enterprise-app-sg"
  }
}
