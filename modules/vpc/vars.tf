variable "vpc_name" {
    type = string
    default = "dev_vpc"
}
variable "public_subnet" {
    type = string
    default = "dev-public"
  
}

variable "private_subnet" {
    type = string
    default = "dev-private"
  
}
variable "map_public_ip" {
  default = true
}


variable "vpc_tenancy" {
    type    = string
    default = "default"
}

variable "vpc_dns_support" {
    type    = bool
    default = "true"
}

variable "vpc_dns_hostnames" {
    type    = bool
    default = "true"
}

variable "cidr_block" {
  type = map
  default = {
    "vpc_cidr"      = "10.0.0.0/16"
    "public_subnet"    = "10.0.1.0/24"
    "private_subnet" = "10.0.10.0/24"
    "route_subnet"   = "0.0.0.0/0"
  }
}


variable "availability_zones" {
  type    = list
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnets" {
  type    = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "type" {
    default = "public"
}

variable "tag" {
  type = list
  default = ["first","second","third"]
}

