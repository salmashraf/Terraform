variable "instance_ami" {
     type = string
}
variable instance_type {
     type = string
} 
variable "security_group" {
  type        = string
}

/* variable "public_cidr" {
  type        = string
  description = "0.0.0.0/0"
} */ 

variable "vpcID" {
  type        = string
}

variable "public_ec2_subnet" {
  type        = map
  description = "instance arguments"
}

/* variable "private_ec2_subnet" {
  type        = map
  description = "instance arguments"
} */ 


variable pub_cidr {
      type = list(string )
}