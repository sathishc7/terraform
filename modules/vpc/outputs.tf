output "public_subnet" {
    value = var.cidr_block["public_subnet"]
}

output "private_subnet" {
    value = var.cidr_block["private_subnet"]
}