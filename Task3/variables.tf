variable "region" {
    type = string
}
variable "config" {
  type = list(string) 
}
variable "credentials" {
      type = list(string) 
}
/* variable "az_number" {
  type = list(number)
} */ 

variable pub_route {
      type = string 
}
variable pub_cidr {
      type = list(string )
}