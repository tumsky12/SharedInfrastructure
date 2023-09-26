resource "azuread_group" "g-owner" {
  display_name     = "owner-${var.resource_environment}"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true

  members = [
    module.constants.owner_user_id
  ]
}

