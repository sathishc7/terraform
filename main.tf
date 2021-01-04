module "ec2" {
    source   = "./modules/ec2"
    keyname = "awscert"
    public_subnet = module.vpc.public_subnet
    private_subnet = module.vpc.private_subnet
    vpc= module.vpc.vpc
}   

module "vpc" {
    source = "./modules/vpc"
    
}