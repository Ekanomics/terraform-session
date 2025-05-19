resource "aws_autoscaling_group" "app_asg" {
  name                      = "${var.env}-app-asg"
  vpc_zone_identifier       = data.terraform_remote_state.vpc.outputs.private_subnet_ids   # Instances in private subnets (fetched from remote state)
  desired_capacity          = 2                                                                 # Number of EC2 instances to launch
  max_size                  = 3                                                                 # max number of instances
  min_size                  = 1                                                                 # min number of instances
  target_group_arns         = [aws_lb_target_group.app_tg.arn]  # Associating ASG with ALB Target Group (ensure that EC2 instances are registered with the ALB for traffic routing and health checks)
  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"                       # specifying latest version of the template
  }

  tag {
    key                 = "Name"
    value               = "app-asg-instance"
    propagate_at_launch = true                                  # Ensure that the tag is applied to the instance, not just ASG
  }

  tag {
    key                 = "Environment"
    value               = var.env
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = var.owner
    propagate_at_launch = true
  }

    tag {
    key                 = "Managed by"
    value               = var.managed_by
    propagate_at_launch = true
  }
}

