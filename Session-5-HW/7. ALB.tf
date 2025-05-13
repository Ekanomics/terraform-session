resource "aws_lb" "app_lb" {
    name = "${var.env}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.lb_sg.id]
    subnets = data.terraform_remote_state.vpc.outputs.public_subnet_ids

    enable_deletion_protection = false

    tags = {
        Name = "${var.env}-alb"
        Environment = var.env
    }
}


# ______________________________________
# Security Group for ALB

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP and HTTPS"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id


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
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}



# ________________________________
# Target Group
resource "aws_lb_target_group" "app_tg" {
  name = "app-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {                  # Configuration of health check
    path = "/"                    # test the root path
    enabled = true                # enables health check to monitor target health
    interval = 30                 # interval between checks 30 sec
    timeout = 5                   # waiting 5 sec for responce
    healthy_threshold = 2         # need 2 successes to mark healthy
    unhealthy_threshold = 2       # need 2 failures to mark unhealthy
    matcher = "200"               # Accepts HTTP 200 codes
  }

  tags = {
    name = "app-tg"
  }
}


# ______________________________
# Listener resource
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  tags = {
    Name = "app-listener"
  }
}


