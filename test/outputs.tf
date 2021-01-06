//output "id" {
//  value = module.key_vault.id
//  description = "The ID of the Key Vault."
//}
//
//output "name" {
//  value = module.key_vault.name
//  description = "The name of the Key Vault."
//}
//
//output "uri" {
//  value = module.key_vault.uri
//  description = "The URI of the Key Vault."
//}
//
//output "secrets" {
//  value = module.key_vault.secrets
//  description = "A mapping of secret names and URIs."
//}
//
//output "references" {
//  value = module.key_vault.references
//  description = "A mapping of Key Vault references for App Service and Azure Functions."
//}


output "grouped_access_policies" {
  value = module.key_vault.grouped_access_policies
}
output "combined_access_policies" {
  value = module.key_vault.combined_access_policies
}