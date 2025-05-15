# _____________________________________
# APPLICATION LOAD BALANCER

resource "aws_lb" "app_lb" {                                                # Creating Load Balancer(ALB)
    name = "${var.env}-alb"
    load_balancer_type = "application"                                      # specifying that this is an Application LB (Layer 7 - HTTP/HTTPS)
    security_groups = [aws_security_group.alb_sg.id]                        # Attaching security group to control traffic to/from the ALB
    subnets = data.terraform_remote_state.vpc.outputs.public_subnet_ids     # ALB must be deployed in public subnets, so it can receive traffic from internet

    tags = {
        Name = "${var.env}-alb"
        Environment = var.env
    }
}


# ______________________________________
# Security Group for ALB

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security Froup for ALB, allow HTTP and HTTPS"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id            # VPC ID where this SG will be created. Being fetched from remote state


# Allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow inbound HTTPS traffic from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Allow outbound traffic from anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                        # "-1" means wildcard, "any protocol"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}



# __________________________________________________
# Target Group
resource "aws_lb_target_group" "app_tg" {
  name = "app-tg"
  port = 80                                                         # Port, which app is listening on
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id           # identifying VPC in which the target group and its instances live

  health_check {                  # Configuration of health check
    path = "/"                    # test the root path
    protocol = "HTTP"             # Use HTTP health check
    interval = 30                 # interval between checks 30 sec
    timeout = 5                   # waiting 5 sec for responce
    healthy_threshold = 2         # need 2 successes to mark healthy
    unhealthy_threshold = 2       # need 2 failures to mark unhealthy
    matcher = "200"               # Accepts HTTP 200 response
  }

  tags = {
    name = "app-tg"
  }
}


# _____________________________________________
# Listener resource
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn                     # Connects listener to the ALB created earlier
  port              = 80                                    # Listen to HTTP port
  protocol          = "HTTP"

  default_action {                                          # What should ALB do with traffic that matches listener
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn       # Specifying target group
  }

  tags = {
    Name = "app-listener"
  }
}


# Summary
# Deployed ALB with: 
# 1) SG allowing HTTP and HTTPS from the public
# 2) ALB placed in public subnets
# 3) Target group to forward traffic to instances
# 4) Listener on port 80 forwarding traffic to the target group



