resource "azurerm_container_app_environment" "app_env" {
  location            = azurerm_resource_group.myf1rg.location
  name                = "f1appenv${var.env_id}"
  resource_group_name = azurerm_resource_group.myf1rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  
    tags = {
        environment = var.env_id
        src = var.src_key
    }
}