resource "aws_instance" "three-tier-web-server" {
  ami                         = "ami-07a00cf47dbbc844c"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.three-tier-web-public-subnet-1.id
  associate_public_ip_address = true
  key_name                    = "LaptopKey"
  vpc_security_group_ids      = [aws_security_group.three-tier-public-subnet.id]
  user_data                   = <<-EOF

#!/bin/bash

apt update -y

apt install docker.io -y

systemctl start docker

systemctl enable docker

usermod -aG docker ubuntu

EOF

  tags = {
    Name = "three-tier-web-server"
  }
}

resource "aws_instance" "three-tier-app-server" {
  ami                         = "ami-07a00cf47dbbc844c"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.three-tier-app-private-subnet-1.id
  associate_public_ip_address = false
  key_name                    = "LaptopKey"
  vpc_security_group_ids      = [aws_security_group.three-tier-private-subnet.id]
  user_data                   = <<-EOF

#!/bin/bash

apt update -y

apt install docker.io -y

systemctl start docker

systemctl enable docker

usermod -aG docker ubuntu

EOF

  tags = {
    Name = "three-tier-app-server"
  }
}