resource "aws_instance" "web" {
  ami           = "ami-0cda377a1b884a1bc"
  instance_type = "t2.micro"
  key_name      = var.keyname
  tags = {
    Name = "tf-mod"
  }
}
