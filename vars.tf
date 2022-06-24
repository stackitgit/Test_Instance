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
    default="vpc-03da4c32bdfe44451"
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
    "subnet-0343c1b675f340001",
    "subnet-0f630a9970b461e7a",
   ]
}



