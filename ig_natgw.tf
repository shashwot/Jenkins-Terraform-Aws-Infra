# CREATE IG 

resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.existing_vpc.id
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-ig"
  }
}

# CREATE ELASTIC IP WITH NAT GATEWAY

resource "aws_eip" "lb" {
  depends_on    = [aws_internet_gateway.gw]
  vpc           = true
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public-subnet-1.id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "${lower(var.vendor)}-${lower(var.environment)}-nat-gw"
  }
}