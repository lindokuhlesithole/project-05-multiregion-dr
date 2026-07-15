variable "app_name" {
  type = string
}

variable "db_password" {
  type    = string
  default = ""
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "hosted_zone_id" {
  type    = string
  default = ""
}

variable "alert_email" {
  type    = string
  default = ""
}

variable "account_id" {
  type    = string
  default = "471147325238"
}
