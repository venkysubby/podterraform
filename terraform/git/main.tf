resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.loc
 tags = {
    environment = "production"
  }
}


resource "azurerm_sql_server" "sql" {
  name                         = var.server
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.versioncontrol
  administrator_login          = var.login
  administrator_login_password = var.loginpassword

  tags = {
    environment = "production"
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storagename
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_database" "example" {
  name                = "myexamplesqldatabase"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql.name

  tags = {
    environment = "production"
  }
}