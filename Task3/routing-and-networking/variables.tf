/* variable "pub_route_names" {
type = string 
} */ 

/* variable "route_names" {
type = map 
}  */ 

variable "route" {
type = map 
}

variable "vpc_cidr" {
type = string 
}

variable "vpc_name" {
type = string
}
variable "public_subnets" {
      type = map  # list(any) 
}  

variable "private_subnets" {
      type = map  # list(any) 
}

variable pub_route {
      type = string 
}

variable "route_table" {
type = map 
}

variable "private_association" {
type = map 
}

variable "public_association" {
type = map 
}
