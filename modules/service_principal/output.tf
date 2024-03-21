output "service_principal_name" {
  description = "The name of the service principal"
  value       = azuread_service_principal.spn-sp.display_name
}

output "service_principal_object_id" {
  description = "The object ID of the service principal"
  value       = azuread_service_principal.spn-sp.object_id
}

output "service_principal_tenant_id" {
  description = "The tenant ID of the service principal"
  value       = azuread_service_principal.spn-sp.application_tenant_id
}

output "client_id" {
  description = "The application ID of the azuread application"
  value       = azuread_application.spn.application_id
}

output "client_secret" {
  description = "The client secret of the service principal"
  value       = azuread_service_principal_password.spn-sp-password.value
}

