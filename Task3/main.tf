module "lab3-vpc" {
    source = "./vpc"
    vpc_name = " lab3"
    vpc_cidr = "10.0.0.0/16"

   # az1 = "us-east-1a"
   # az2 = "us-east-1b"
   # subnet_cidr1 = ["10.0.0.0/24","10.0.1.0/24"]

    public_subnets = {
       "subnet1" = { cidr = "10.0.0.0/24" , az = "us-east-1a" },
       "subnet3" = { cidr = "10.0.2.0/24" , az = "us-east-1b" }
    }
    private_subnets = {
       "subnet2" = { cidr = "10.0.1.0/24" , az = "us-east-1a" },
       "subnet4" = { cidr = "10.0.3.0/24" , az = "us-east-1b" }

    } 
}

module "routing-and-networking" {
    source = "./routing-and-networking"
    vpc_name = " lab3"
    vpc_cidr = "10.0.0.0/16"
    pub_route = "0.0.0.0/0"
    # pub_cidr = ["0.0.0.0/0"]
    
    route_table = {
     "table1" = "pub_route_table"
     "table2" = "priv_route_table"
     }
    /* priv_route_names = {
    "table2" = "priv_route_table1"
     # "table4" = "priv_route_table2"
    } */ 

    route = {
    "public_route" = { id = module.routing-and-networking.public_route_table_id, destination = module.routing-and-networking.gateway_id },
    "private_route" = { id = module.routing-and-networking.private_route_table_id, destination = module.routing-and-networking.nat_id }
    }
    public_subnets = {
       "subnet1" = { cidr = "10.0.0.0/24" , az = "us-east-1a" },
       "subnet3" = { cidr = "10.0.2.0/24" , az = "us-east-1b" }
    }
    private_subnets = {
       "subnet2" = { cidr = "10.0.1.0/24" , az = "us-east-1a" },
       "subnet4" = { cidr = "10.0.3.0/24" , az = "us-east-1b" }

    }
   public_association = {
    "publicSubnet_association1"  = { id = module.routing-and-networking.public_subnet1_id, tableid = module.routing-and-networking.public_route_table_id },
    "publicSubnet_association2"  = { id = module.routing-and-networking.public_subnet2_id, tableid = module.routing-and-networking.public_route_table_id },
   }
   private_association = {
    "privateSubnet_association1" = { id = module.routing-and-networking.private_subnet1_id, tableid = module.routing-and-networking.private_route_table_id },
    "privateSubnet_association2" = { id = module.routing-and-networking.private_subnet2_id, tableid = module.routing-and-networking.private_route_table_id }
   } 
}
   

module "lab3_ec2" {
 source = "./ec2"
 instance_ami    = "ami-06878d265978313ca"
 instance_type = "t2.micro"
 pub_cidr = ["0.0.0.0/0"]

 # public_cidr    = "0.0.0.0/0"
 security_group = "ec2 security group"
 vpcID          = module.routing-and-networking.vpc-id
 # ami            = "ami-00874d747dde814fa"

 public_ec2_subnet = {
    "public_ec2_1" = module.routing-and-networking.public_subnet1_id,
    "public_ec2_2" = module.routing-and-networking.public_subnet2_id
  }

 /* private_ec2_subnet = {
    "private_ec2_1" = module.routing-and-networking.private_subnet1_id,
    "private_ec2_2" = module.routing-and-networking.private_subnet2_id
  } */ 

} 
module "loadbalancer" {
  source      = "./loadbalancer"
  vpcID          = module.routing-and-networking.vpc-id
  target_type = "instance"
  target_group = {
    "public" = "publicAlb-target-group" 
    "private" = "privateAlb-target-group" 
   }
   instanceID = {
    "public_ec2_id_1"  = { targetGroup = module.loadbalancer.public_alp_target_group_id , ec2 = module.lab3_ec2.public_ec2_id_1 },
    "public_ec2_id_2"  = { targetGroup = module.loadbalancer.public_alp_target_group_id , ec2 = module.lab3_ec2.public_ec2_id_2 },
    
    # "private_ec2_id_1" = { targetGroup = module.loadbalancer.private_alp_target_group_id , ec2 = module.lab3_ec2.private_ec2_id_1 },
    # "private_ec2_id_2" = { targetGroup = module.loadbalancer.private_alp_target_group_id , ec2 = module.lab3_ec2.private_ec2_id_2 }
   }
   load_balancer = {
    "publicAlb" = { subnets = [ module.routing-and-networking.public_subnet1_id, module.routing-and-networking.public_subnet2_id], internal = false },
    "privateAlb" = { subnets = [ module.routing-and-networking.private_subnet1_id, module.routing-and-networking.private_subnet2_id ], internal = true }
  }
  security_group = "loadBalancer-security-group"
  pub_cidr = ["0.0.0.0/0"]
  load_balancer_type = "application"
  ip_address_type = "ipv4"

  
  }




