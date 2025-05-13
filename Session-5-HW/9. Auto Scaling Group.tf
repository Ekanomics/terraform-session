resource "aws_autoscaling_group" "web_asg" {
  name                      = "web-asg"
  vpc_zone_identifier       = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  target_group_arns         = [aws_lb_target_group.app_tg.arn]
  health_check_type         = "ELB"
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "web-asg-instance"
    propagate_at_launch = true
  }
}