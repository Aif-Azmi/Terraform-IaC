terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Create an isolated Docker network for our app and database
resource "docker_network" "app_network" {
  name   = "flask-mysql-network"
  driver = "bridge"
}

output "network_id" {
  description = "ID of the created Docker network"
  value       = docker_network.app_network.id
}