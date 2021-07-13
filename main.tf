provider "azurerm" {
    version = "2.5.0"
    features {}
}

variable "imagebuild" {
  type        = string
  default     = "latest"
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "UK South"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "tomwhiweather"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "tomwhi69/weatherapi:${var.imagebuild}"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}