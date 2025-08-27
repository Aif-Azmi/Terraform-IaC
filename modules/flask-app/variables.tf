variable "network_id" {
  description = "ID of the Docker network to connect to"
  type        = string
}

variable "mysql_host" {
  description = "Hostname of the MySQL container"
  type        = string
}

variable "db_name" {
  description = "Name of the database to connect to"
  type        = string
}

variable "db_root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "mysql_depends_on" {
  description = "Reference to the MySQL container to ensure proper startup order"
  type        = any
}