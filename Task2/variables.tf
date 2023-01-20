variable "region" {
    type = string
}
variable "config" {
  type = list(string) 
}
variable "credentials" {
      type = list(string) 
}
variable "vpc_cidr" {
      type = string
}

variable instance_type {
     type = string
}
variable pub_route {
      type = string 
}
variable pub_cidr {
      type = list(string )
}
variable subnet_cidr {
      type = list(any)
}