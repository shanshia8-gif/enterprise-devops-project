variable "aws_region" {
  description = "AWS region where infrastructure will be created"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
  default     = "terraform-key"
}

variable "ami_id" {
  description = "Amazon Linux AMI ID for ap-south-1"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}
