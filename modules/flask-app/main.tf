terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Use the pre-built Docker image (we built it manually)
resource "docker_image" "flask_app_image" {
  name = "my-flask-app:latest"
  
  # This tells Terraform to use the existing locally built image
  keep_locally = true
}

# Create the Flask app container
resource "docker_container" "flask_app" {
  name  = "flask-application"
  image = docker_image.flask_app_image.image_id

  # Environment variables for the Flask app
  env = [
    "DB_HOST=${var.mysql_host}",
    "DB_USER=root",
    "DB_PASSWORD=${var.db_root_password}",
    "DB_NAME=${var.db_name}"
  ]

  # Connect to the same network as MySQL
  networks_advanced {
    name = var.network_id
  }

  # Forward port 8000 on host to port 5000 in container
  ports {
    internal = 5000
    external = 8000
  }

  # Wait for MySQL to be healthy before starting
  depends_on = [var.mysql_depends_on]
}

output "container_name" {
  description = "Name of the Flask application container"
  value       = docker_container.flask_app.name
}