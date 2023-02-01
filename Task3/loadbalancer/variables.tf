variable "target_type" {
  type        = string
}

variable target_group {
  type        = map

}

variable "vpcID" {
  type        = string
}

variable "instanceID"{
    type        = map
}
variable "security_group" {
  type        = string
}

variable pub_cidr {
      type = list(string )
}
variable load_balancer {
  type        = map
}
variable load_balancer_type {
  type        = string
}
variable ip_address_type {
  type        = string
}
variable listener {
  type        = map
}




