variable "aws_region" {
  description = "AWS region used for the project."
  type        = string
  default     = "ap-south-1"
}

variable "aws_profile" {
  description = "Local AWS CLI profile Terraform is allowed to use."
  type        = string
  default     = "assignment"
}

variable "project_name" {
  description = "Prefix applied to AWS resource names."
  type        = string
  default     = "aws-devops-platform"
}

variable "key_name" {
  description = "Existing EC2 key pair name used for Ansible SSH access."
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Trusted public IP range allowed to SSH to the EC2 host."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for the all-in-one lab host."
  type        = string
  default     = "t3.medium"
}
