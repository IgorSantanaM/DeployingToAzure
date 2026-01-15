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
   default = "79eecdd3-63ef-4e2b-a659-3385393b3d85"
}

variable "sql_pass" {
  type = string
  description = "The SQL Server password"
}