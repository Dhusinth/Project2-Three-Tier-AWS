resource "aws_db_instance" "three-tier-db-instance" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "Dhusinth"
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.three-tier-db-subnet-group.name
}

resource "aws_db_subnet_group" "three-tier-db-subnet-group" {
  name       = "three-tier-db-subnet-group"
  subnet_ids = [aws_subnet.three-tier-db-private-subnet-1.id, aws_subnet.three-tier-db-private-subnet-2.id]

  tags = {
    Name = "three-tier-db-subnet-group"
  }
}