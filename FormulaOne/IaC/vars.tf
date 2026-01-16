variable "env_id" {
    type = string
    description = "The environment id"
    default = "dev"
}

variable "src_key" {
  type = string
  description = "The infrastructure source"
  default = "terraform"
}

variable "subscription_id" {
    type = string
    description = "The Azure subscription id"
}

variable "sql_pass" {
  type = string
  description = "The SQL Server password"
}