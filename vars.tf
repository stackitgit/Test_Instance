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
    default="vpc-076bca924cc2b6ef3"
}


variable "ami" {
  default = "ami-0918b4234031affa6"
}

variable "instance_type"{
  default ="t3.medium"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-0c1bf1ccd93da60d2",
    "subnet-0efe1e752b98eaf2c",
   ]
}



