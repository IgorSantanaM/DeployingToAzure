resource "azurerm_mssql_server" "sql_server" {
  location            = azurerm_resource_group.myf1rg.location
  name                = "formulaone-sqlserver-${var.env_id}a1q"
  resource_group_name = azurerm_resource_group.myf1rg.name
  version             = "12.0"
  administrator_login          = "f1admin"
  administrator_login_password = var.sql_pass

  tags = {
    environment = var.env_id
    src = var.src_key
  }
}

resource "azurerm_mssql_database" "db" {
  name      = "formulaone-db"
  server_id = azurerm_mssql_server.sql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 10
  sku_name     = "S1"
  zone_redundant = false
  
  lifecycle {
    prevent_destroy = false
  }
  
    tags = {
        environment = var.env_id
        src = var.src_key
    }
}

resource "azurerm_mssql_firewall_rule" "rule" {
  end_ip_address   = "0.0.0.0"
  name             = "all_azure"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
}