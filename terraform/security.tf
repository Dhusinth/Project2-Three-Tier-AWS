resource "aws_security_group" "three-tier-internet-alb" {
  name        = "three-tier-internet-alb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-internet-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "three-tier-internal-alb-ingress" {
  security_group_id = aws_security_group.three-tier-internet-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "three-tier-internal-alb-ingress" {
  security_group_id = aws_security_group.three-tier-internet-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "three-tier-public-subnet" {
  name        = "three-tier-nginx-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-public-subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "three-tier-public-subnet-ingress" {
  security_group_id            = aws_security_group.three-tier-public-subnet.id
  referenced_security_group_id = aws_security_group.three-tier-internet-alb.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "three-tier-public-subnet-egress" {
  security_group_id = aws_security_group.three-tier-public-subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "three-tier-internal-alb" {
  name        = "three-tier-internal-alb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-public-subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "three-tier-internet-alb-ingress" {
  security_group_id            = aws_security_group.three-tier-internal-alb.id
  referenced_security_group_id = aws_security_group.three-tier-public-subnet.id
  from_port                    = 5000
  ip_protocol                  = "tcp"
  to_port                      = 5000
}

resource "aws_vpc_security_group_egress_rule" "three-tier-internet-alb-egress" {
  security_group_id = aws_security_group.three-tier-internal-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "three-tier-private-subnet" {
  name        = "three-tier-flask-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-public-subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "three-tier-private-subnet-ingress" {
  security_group_id            = aws_security_group.three-tier-private-subnet.id
  referenced_security_group_id = aws_security_group.three-tier-internal-alb.id
  from_port                    = 5000
  ip_protocol                  = "tcp"
  to_port                      = 5000
}

resource "aws_vpc_security_group_egress_rule" "three-tier-private-subnet-egress" {
  security_group_id = aws_security_group.three-tier-private-subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "three-tier-private-db-subnet" {
  name        = "three-tier-db-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three-tier-public-subnet"
  }
}

resource "aws_vpc_security_group_ingress_rule" "three-tier-db-subnet-ingress" {
  security_group_id            = aws_security_group.three-tier-private-db-subnet.id
  referenced_security_group_id = aws_security_group.three-tier-private-subnet.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "three-tier-db-subnet-egress" {
  security_group_id = aws_security_group.three-tier-private-db-subnet.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

