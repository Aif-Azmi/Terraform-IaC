terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Pull the MySQL 8.0 image
resource "docker_image" "mysql_image" {
  name = "mysql:8.0"
}

# Create the MySQL container
resource "docker_container" "mysql_db" {
  name  = "mysql-server"
  image = docker_image.mysql_image.image_id

  # Environment variables for MySQL configuration
  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}",
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_TCP_PORT=3306"
  ]

  # Connect to our isolated network
  networks_advanced {
    name = var.network_name
  }

  # Optional: Add a healthcheck to ensure MySQL is ready
  healthcheck {
    test     = ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${var.db_root_password}"]
    interval = "5s"
    timeout  = "5s"
    retries  = 10
  }
}

output "container_name" {
  description = "Name of the MySQL container"
  value       = docker_container.mysql_db.name
}

output "container_ip" {
  description = "IP address of the MySQL container on the network"
  value       = docker_container.mysql_db.network_data[0].ip_address
}

output "container_id" {
  description = "ID of the MySQL container"
  value       = docker_container.mysql_db.id
}