resource "azurerm_resource_group" "myf1rg" {
  location = "UK South"
  name     = "f1-rg"
  
  tags = {
    environment = var.env_id
    src = var.src_key
  }
}