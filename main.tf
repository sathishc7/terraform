module "ec2" {
    source   = "./modules/ec2"
    keyname = "awscert"
}   

module "vpc" {
    source = "./modules/vpc"
    
}