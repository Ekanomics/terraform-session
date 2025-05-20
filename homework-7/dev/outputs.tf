output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns" {
  value = module.alb.dns_name
}

output "acm_certificate_arn" {
  value = module.acm_route53.certificate_arn
}

