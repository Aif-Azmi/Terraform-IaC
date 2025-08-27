variable "db_root_password" {
  description = "The root password for MySQL"
  type        = string
  sensitive   = true
  default     = "my-secret-pw"
}

variable "db_name" {
  description = "The name of the database"
  type        = string
  default     = "flaskdb"
}

variable "network_name" {
  description = "The name of the Docker network"
  type        = string
  default     = "flask-mysql-network"
}