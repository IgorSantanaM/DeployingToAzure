resource "azurerm_container_app" "app" {
  container_app_environment_id = azurerm_container_app_environment.app_env.id
  name                         = "f1-api-${var.env_id}"
  resource_group_name          = azurerm_resource_group.myf1rg.name
  revision_mode                = "Multiple"
  
  template {
    min_replicas = 1
    max_replicas = 3 
    
    container {
      cpu    = 0.25
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      memory = "0.5Gi"
      name   = "f1app-${var.env_id}"
    }
  }
  
  ingress {
    allow_insecure_connections = false
    external_enabled = true
    target_port = 8080
    
    traffic_weight {
      percentage = 100
      label = "primary"
      latest_revision = true
    }
  }
  
    tags = {
        environment = var.env_id
        src = var.src_key
    }
}