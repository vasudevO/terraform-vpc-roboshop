variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  
}
variable "env" {
    type = string
  
}
variable "project_name" {
    type = string
  
}
variable "common_tags" {
  description = "tags for the vpc"
  type        = map(string)
  default = {
    "Billing" = "platform"
  }

  
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool 
 
  
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool

  
}


variable "public_subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = list(string)
  
  
}


variable "private_subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = list(string)
  
  
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
 
  
}

# variable "subnet_tags" {
#   description = "tags for the subnet"
#   type        = map(string)
#   default     = {
#     Project     = "roboshop"
#     Environment = "dev"
#     "Name"      = "roboshop-subnet"
#   }
  
# }

# variable "route_tablre_cidr_block" {
#   description = "The CIDR block for the route table"
#   type        = string
#   default     = "0.0.0.0/0"
  
# }

# variable "route_table_tags" {
#   description = "tags for the route table"
#   type        = map(string)
#   default     = {
#     Project     = "roboshop"
#     Environment = "dev"
#     "Name"      = "roboshop-route-table"
#   }
  
# }

# variable "igw_tags" {
#   description = "tags for the internet gateway"
#   type        = map(string)
#   default     = {
#     Project     = "roboshop"
#     Environment = "dev"
#     "Name"      = "roboshop-igw"
#   }
  
# }


# ############################################
# # variables fr sg.tf
# ############################################

# variable "sg_name" {
#   description = "Name of the security group"
#   type        = string
#   default     = "roboshop-sg"
# }

# variable "tags_sg" {
#   description = "tags for the security group"
#   type        = map(string)
#   default     = {
#     Project     = "roboshop"
#     Environment = "dev"
#     "Name"      = "roboshop-sg"
#   }
  
# }

# variable "ssh_port" {
#   description = "Port for SSH access"
#   type        = number
#   default     = 22
  
# }

# variable "allowed_cidr_block" {
#   description = "CIDR block to allow access from"
#   type        = list(string)
#   default     = ["0.0.0.0/0"]

# }

# ############################################
# # variables for ec2.tf
# ############################################

# variable "instance_type" {
#   description = "EC2 instance type"
#   type        = string
#   default     = "t3.micro"

# }


# variable "ami" {
#   description = "AMI ID for the EC2 instance"
#   type        = string
#   default     = "ami-00ca32bbc84273381" 

# }

# variable "key_name" {
#   description = "Key pair name for SSH access"
#   type        = string
#   default     = "linux-class" 

# }

# variable "tags_instance" {
#   description = "tags for the EC2 instance"
#   type        = map(string)


# }

# variable "associate_public_ip_address" {
#   description = "Whether to associate a public IP address"
#   type        = bool
#   default     = true
  
# }


# variable "instance_name" {
#   description = "Name of the instance"
#   type        = map
  
  
# }