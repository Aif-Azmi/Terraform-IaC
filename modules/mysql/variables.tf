variable "network_name" {
  description = "Name of the Docker network to connect to"
  type        = string
}

variable "db_root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
}