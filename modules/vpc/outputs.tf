output "public_subnet" {
    value = aws_subnet.publicsubnet.id
}

output "private_subnet" {
    value = aws_subnet.privatesubnet.id
}

output "vpc" {
  value = aws_vpc.dev_vpc.id
}