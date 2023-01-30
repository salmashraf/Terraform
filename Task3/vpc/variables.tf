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

/* variable "zone" {
      type = map  
} */

/*variable "public" {
  type = map 
  
} */ 
/* variable "az2" {
      type = string  
} */ 
