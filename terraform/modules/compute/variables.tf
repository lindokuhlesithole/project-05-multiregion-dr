variable "app_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "task_count" {
  type    = number
  default = 0
}
