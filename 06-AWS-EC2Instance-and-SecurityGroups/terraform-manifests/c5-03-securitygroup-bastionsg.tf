# AWS EC2 Security Group Terraform Module
# Security Group for Public Bastion Host

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name = "public_bastion_sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"

  vpc_id = 
}