resource "aws_instance" "web-app" {
  ami           = "ami-0cda377a1b884a1bc"
  instance_type = "t2.micro"
  key_name      = var.keyname
  subnet_id     = module.vpc.public_subnet
  tags = {
    Name = "web-instance"
  }
}


resource "aws_instance" "db" {
  ami           = "ami-0cda377a1b884a1bc"
  instance_type = "t2.micro"
  key_name      = var.keyname
  subnet_id     = module.vpc.private_subnet
  tags = {
    Name = "db-instance"
  }
}


module "vpc" {
  source = "../vpc"
}
