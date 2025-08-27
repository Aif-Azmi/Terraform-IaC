terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
  
  # Add registry authentication (helps with some Docker Desktop issues)
  registry_auth {
    address = "docker.io"
  }
}