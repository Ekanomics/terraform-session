#         # Naming Convention - Naming Standard

# 1. Provider Name: aws, azure, gcp, do, alibaba
# 2. Region: usw1, usw2, use1, use2
# 3. Resource Type: ec2, s3, sqs, asg, alb, efs
# 4. Environment: dev, qa, stage, prod
# 5. Business Unit: orders, payments, streaming
# 6. Project Name: unicorn, batman, to, jerry, ihop, ipa
# 7. Tier: frontend, backend, db


# Example: aws-usw2-vpc-orders-db-tom-dev




#  ___________________________________________________ 
#           Tagging Standard - Common Tags

# 1. Environment: dev, qa, stage, prod
# 2. Project Name: unicorn, tom, jerry, batman
# 3. Business Unit: orders, payment, streaming
# 4. Team: DevOps, DRE, SRE, Security
# 5. Owner: kris@akumosolutions.io 
# 6. Managed_by: cloudformation, terraform, python, manual
# 7. Lead: akmal@akumosolutions.io
# 8. Market: eu, na, asia




# ____________________________________________________


locals {
    
    # Naming Standard
    name = "${var.provider_name}-${var.region}-rtype-${var.business_unit}-${var.tier}-${var.project}-${var.env}"

    # Tagging standard
    common_tags = {
      Environment = var.env
      Project_Name = var.project
      Business_Unit = var.business_unit
      Team = var.team
      Owner = var.owner
      Managed_By = var.managed_by
    }

}



