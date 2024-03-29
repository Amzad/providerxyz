# providerxyz :: terraform

## BACKENDS
terraform {
  backend "remote" {}
}

## PROVIDERS
provider "azuread" {
  version = "~>0.4.0"
}

provider "azurerm" {
  version = "~>1.30.0"
}

provider "cloudflare" {
  version = "~>1.16.0"
}

## RESOURCES
resource "azurerm_app_service" "providerxyz" {
  app_service_plan_id = "${azurerm_app_service_plan.providerxyz.id}"
  https_only = "${var.app_service["https"]}"
  location = "${azurerm_resource_group.providerxyz.location}"
  name = "${var.app_service["name"]}"
  resource_group_name = "${azurerm_resource_group.providerxyz.name}"

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    app_command_line = ""
    linux_fx_version = "COMPOSE|${filebase64(var.app_service["linux"])}"
  }
}

resource "azurerm_app_service_custom_hostname_binding" "providerxyz" {
  app_service_name = "${azurerm_app_service.providerxyz.name}"
  hostname = "${var.app_service_custom["hostname"]}"
  resource_group_name = "${azurerm_resource_group.providerxyz.name}"

  depends_on = ["cloudflare_record.providerxyz"]
}

resource "azurerm_app_service_plan" "providerxyz" {
  kind = "${var.app_service_plan["kind"]}"
  location = "${azurerm_resource_group.providerxyz.location}"
  name = "${var.app_service_plan["name"]}"
  resource_group_name = "${azurerm_resource_group.providerxyz.name}"
  reserved = "${var.app_service_plan["reserved"]}"

  sku {
    size = "${var.app_service_plan["size"]}"
    tier = "${var.app_service_plan["tier"]}"
  }
}

resource "azurerm_resource_group" "providerxyz" {
  name = "${var.resource_group["name"]}"
  location = "${var.resource_group["location"]}"

  tags = {
    owner = "${var.resource_group["owner"]}"
  }
}

resource "cloudflare_record" "providerxyz" {
  domain = "${var.cloudflare_record["domain"]}"
  name = "${var.cloudflare_record["name"]}"
  proxied = "${var.cloudflare_record["proxied"]}"
  ttl = "${var.cloudflare_record["ttl"]}"
  type = "${var.cloudflare_record["type"]}"
  value = "${var.cloudflare_record["value"]}"
}
