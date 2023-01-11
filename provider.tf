provider "aws" {
  region = var.AWS_REGION
 default_tags {
   tags = {

      environment = "dev"

      # #sandbox, dev, test, qa, uat, stage, prod, hotfix, train, mgmt

   }
 }

 assume_role {
    role_arn    = "arn:aws:iam::560089993749:role/Engineer"
  
  }
}


