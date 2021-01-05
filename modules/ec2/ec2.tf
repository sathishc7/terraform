resource "aws_instance" "web-app" {
  ami           = var.ami
  instance_type = "t3a.medium"
  key_name      = var.keyname
  vpc_security_group_ids = ["${aws_security_group.web-app.id}"]
  subnet_id     = var.public_subnet
  tags = {
    Name = "web-instance"
  }
}


resource "aws_instance" "db" {
  ami           = var.ami
  instance_type = "t3a.medium"
  key_name      = var.keyname
  vpc_security_group_ids = ["${aws_security_group.db-sg.id}"]
  subnet_id     = var.private_subnet
  tags = {
    Name = "db-instance"
  }
}

variable "web-app-sg" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [443, 80,]
}

resource "aws_security_group" "web-app" {
  name        = "web-app-sg"
  vpc_id      = var.vpc

  dynamic "ingress" {
    for_each = var.web-app-sg
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.web-app-sg
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
   tags = {
    Name = "webapp-sg"
  }
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.web-app.private_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

/* module "vpc" {
  source = "../vpc/"
}
 */
