# Create the network
module "app_network" {
  source = "./modules/network"
}

# Create the MySQL database
module "mysql_db" {
  source = "./modules/mysql"

  network_name     = module.app_network.network_id
  db_root_password = var.db_root_password
  db_name          = var.db_name
}

# Create the Flask application
module "flask_app" {
  source = "./modules/flask-app"

  network_id       = module.app_network.network_id
  mysql_host       = module.mysql_db.container_name
  db_name          = var.db_name
  db_root_password = var.db_root_password
  mysql_depends_on = module.mysql_db.container_id  # ADD THIS LINE
}