variable "ami" {
  default = "ami-005ee9e4d4fd438eb"
}

variable "key_name" {
  description = "SSH Key used for the servers."
}

variable "subnet_id" {
  description = "Subnet ID information for the Web servers."
}

variable "vpc_id" {
  description = "VPC ID information for TF servers."
}

variable "owner" {
    description = "Owner Tag for resources"
}