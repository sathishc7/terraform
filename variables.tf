variable "ami" {
  default     = "ami-0cda377a1b884a1bc"
  description = "Server image"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type to provision"

}

variable "keyname" {
  type        = string
  default     = "awscert"
  description = "Key to access the server"
}

variable "tags" {
  type    = list
  default = ["web-dev", "web-stg"]
}

//variable "subnet" {
//  subnet = "module.vpc.subnet"
//}
