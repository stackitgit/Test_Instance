# variable "AWS_ACCESS_KEY" {}

# variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
 default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "ses_key.pub"
}

variable "vpc_id"{
    default="vpc-0c80b6e8f814de308"
}


variable "ami" {
  default = "ami-08f3d892de259504d"
}

variable "instance_type"{
  default ="t2.small"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-0579923556edc99df",
    "subnet-0943e3dba385fe892",
   ]
}



