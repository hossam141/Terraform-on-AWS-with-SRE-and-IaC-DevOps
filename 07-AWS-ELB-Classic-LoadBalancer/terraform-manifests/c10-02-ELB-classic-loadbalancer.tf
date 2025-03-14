module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "4.0.1"
  
  name = "${local.name}-myelb"

  subnets         = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  security_groups = [module.loadbalancer_sg.security_group_id]
  #internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "http"
      lb_port           = 81
      lb_protocol       = "http"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = length(module.ec2_private)
  instances           = [for ec2private in module.ec2_private: ec2private.id ] 

  tags = local.common_tags
}