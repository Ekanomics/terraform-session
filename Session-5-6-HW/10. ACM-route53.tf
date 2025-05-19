# ACM Certificate
resource "aws_acm_certificate" "alb_cert" {
  domain_name       = var.domain_name               # Request an SSL/TLS certificate from AWS ACM for the domain
  validation_method = "DNS"                         # Chooses DNS-based validation, which requires a DNS record to be created in Route 53 (alternative is email validation)

  lifecycle {                                       # Ensures cert is created before destroying an existing one during updates (zero downtime)
    create_before_destroy = true
  }

  tags = {
    Name = "alb-cert"
  }
}


# Route53 Record for ACM DNS Validation
resource "aws_route53_record" "alb_cert_validation" {                                                 # Creates DNS records needed for certificate validation
  for_each = {                                                                                        # Loops through all domain validation options
    for dvo in aws_acm_certificate.alb_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id      # refers to hosted zone for the domain
  name    = each.value.name
  type    = each.value.type         # Record type (usually CNAME)
  ttl     = 60                      # Time to live for the DNS record
  records = [each.value.record]
}


# Route53 zone data source
data "aws_route53_zone" "main" {              # Looks up an existing Route53 hosted zone
  name         = var.domain_name              # Finds zone matching our domain name
  private_zone = false                        # Specifies this is a public (not private) DNS zone
}



# ACM Certificate Validation
resource "aws_acm_certificate_validation" "alb_cert_validation" {                                 #This resource waits for ACM to verify the records and issue the certificate
  certificate_arn         = aws_acm_certificate.alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.alb_cert_validation : record.fqdn]
}

# HTTPS Listener for ALB
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"                                           # defines TLS protocol settings
  certificate_arn   = aws_acm_certificate_validation.alb_cert_validation.certificate_arn    #links validated cert to the listener

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn               # Forward requests to the target group app_tg
  }
}

# Route53 Alias Record for ALB
resource "aws_route53_record" "alb_alias" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"                                 # Creating Alias A record pointing to your ALB

  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true                   # Enables Route 53 to evaluate ALB health for failover support
  }
}