variable "vpc-cidr-block" {
  type        = string
  description = "vpc cidr block"
  default = "10.0.0.0/16"
}


variable "vpc-name" {
  type        = string
  description = "vpc name"
  default = "VPC-V1"
}


variable "region" {
  type        = string
  description = "region"
  default = "us-east-1"
}


variable "publicsubnet-1-cidr" {
  type        = string
  description = "Public subnet 1 cidr block"
  default = "10.0.1.0/24"
}



variable "publicsubnet-2-cidr" {
  type        = string
  description = "Public subnet 2 cidr block"
  default = "10.0.2.0/24"
}



variable "privatesubnet-1-cidr" {
  type        = string
  description = "Public subnet 1 cidr block"
  default = "10.0.3.0/24"
}


variable "privatesubnet-2-cidr" {
  type        = string
  description = "Public subnet 2 cidr block"
  default = "10.0.4.0/24"
}


variable "privatesubnet-3-cidr" {
  type        = string
  description = "Public subnet 3 cidr block"
  default = "10.0.5.0/24"
}


variable "privatesubnet-4-cidr" {
  type        = string
  description = "Public subnet 4 cidr block"
  default = "10.0.6.0/24"
}