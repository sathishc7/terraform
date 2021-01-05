module "ec2" {
    source   = "./modules/ec2"
    keyname = "tf-ne"
    public_subnet = module.vpc.public_subnet
    private_subnet = module.vpc.private_subnet
    vpc= module.vpc.vpc
    ami = "ami-023a7615a07affbe5"
}   

module "vpc" {
    source = "./modules/vpc"
    
}
