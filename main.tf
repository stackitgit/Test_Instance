# locals {
#   ddog_key = jsondecode(
#     data.aws_secretsmanager_secret_version.ddapikey.secret_string
#   )
# }

#DATA SOURCES

# data "aws_iam_instance_profile" "ssm-instance-prof" {
#   # name = "AmazonSSMRoleForInstancesQuickSetup"
#   name = "AWSServiceRoleForAmazonSSM"
# }

#Extract Secrets

# data "aws_secretsmanager_secret_version" "ddapikey" {
#   # Fill in the name you gave to your secret
#   secret_id = "datadog_api_key"
# }

#Set Bootstrap script
data "template_file" "bootstrap" {
    template = file(format("%s/scripts/bootstrap.tpl", path.module))  
}
 # vars={
    #   Datadog_API_Key=local.ddog_key.datadog_api_key
      
    # }

#Create Security Group
resource "aws_security_group" "datadog-sg" {
  vpc_id     = var.vpc_id
  name        = "Datadog-WebDMZ"
  description = "Datadog Security Group For Datadog Instance"
}

#Add rule to SSH into EC2 instance
resource "aws_security_group_rule" "ssh" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["10.0.0.0/8"]
}

resource "aws_security_group_rule" "http" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "dns" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "smtp" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 25
  to_port           = 25
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "oracle" {
  security_group_id = aws_security_group.datadog-sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 1521
  to_port           = 1521
  cidr_blocks       = ["0.0.0.0/0"]
}




resource "aws_instance" "Test_Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.datadog-sg.id]
  # key_name                    = aws_key_pair.seskp.key_name
  subnet_id                   = var.subnets[0]
  user_data                   = data.template_file.bootstrap.rendered 
  # iam_instance_profile        = data.aws_iam_instance_profile.ssm-instance-prof.name
  root_block_device {
    volume_type               = "gp2"
    volume_size               = 30
    delete_on_termination     = true
    encrypted= "false"
  }

  tags                        = {
  Name                        = "Datadog-SB-Server"
}
}



