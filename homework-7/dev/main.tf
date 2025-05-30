module "vpc" {
  source = "./modules/vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "alb" {
  source = "../modules/alb"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
}


module "asg" {
  source = "../modules/asg"

  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  target_group_arn    = module.alb.target_group_arn
  alb_sg_id           = module.alb.sg_id
}


module "acm_route53" {
  source = "../modules/acm_route53"

  domain_name   = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  alb_dns_name = module.alb.dns_name
  alb_zone_id  = module.alb.zone_id
}





# module "vpc" {
#   source              = "./modules/vpc"
#   vpc_cidr            = "10.0.0.0/16"
#   public_subnet_cidrs = ["10.0.1.0/24"]
#   private_subnet_cidrs = ["10.0.2.0/24"]
# }

# module "asg" {
#   source = "./modules/asg"
#   ...
#   vpc_id = module.vpc.vpc_id
#   ...
# }

# module "alb" {
#   source     = "./modules/alb"
#   vpc_id     = module.vpc.vpc_id
#   subnets    = module.vpc.public_subnets
#   ...
# }

# module "acm_route53" {
#   source          = "./modules/acm_route53"
#   domain_name     = var.domain_name
#   hosted_zone_id  = var.hosted_zone_id
#   alb_dns_name    = module.alb.dns_name
#   alb_zone_id     = module.alb.alb_zone_id
# }





























# ######### Root Module ##########

# # ______________________________



# module "sg" {
#   source = "../../modules/sg"    # Where the child module is. WHen you call child module locally, you use the path
#   ##### Variables #######
#   name = "dev-instance-sg"
#   description = "This a sg for dev instance"
#   ingress_ports = [ 22 ]
#   ingress_cidr = [ "10.0.0.0/32" ]
# }


# module "ec2" {
#   source = "../../modules/ec2"
#   ### variables
#   env = "dev"
#   instance_type = "t2.micro"
#   ami = data.aws_ami.amazon_linux_2023.id         # Reference to Data Source
#   vpc_security_group_ids = [module.sg.security_group_id]         # Reference to Child Module
# }


# # Fetch Amazon Linux 2023 AMI ID
# data "aws_ami" "amazon_linux_2023" {
#   most_recent      = true
#   owners           = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.7.*"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }



# ############### Calling Terraform Modules Remotely
# # terraform Registry - Official Child Module

# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"    # Terraform registry

#   name = "my-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }



# module "erkin_github_sg" {
#   source = "github.com/Ekanomics/terraform-session/modules/sg"
#   name = "erkin-sg"
#   description = "This a sg for dev instance"
#   ingress_ports = [ 22 ]
#   ingress_cidr = [ "10.0.0.0/32" ]
# }

