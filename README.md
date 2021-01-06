# Key Vault

Create Key Vault in Azure.

## Example Usage

```hcl
resource "azurerm_resource_group" "main" {
  name     = "example-resources"
  location = "westeurope"
}

module "key_vault" {
  source = "innovationnorway/key-vault/azurerm"

  name = "example"

  resource_group_name = azurerm_resource_group.main.name

  access_policies = [
    {
     user_principal_names = ["user@example.com"]
     secret_permissions   = ["get", "list"]
    },
    {
     group_names        = ["developers", "engineers"]
     secret_permissions = ["get", "list", "set"]
    },
  ]

  secrets = {
    "message" = "Hello, world!"
  }
}
```

## Arguments

| Name | Type | Description |
| --- | --- | --- |
| `name` | `string` | The name of the Key Vault. |
| `resource_group_name` | `string` | The name of an existing resource group for the Key Vault. |
| `sku` | `string` | The name of the SKU used for the Key Vault. The options are: `standard`, `premium`. Default: `standard`. |
| `enabled_for_deployment` | `bool` | Allow Virtual Machines to retrieve certificates stored as secrets from the Key Vault. Default: `false`. |
| `enabled_for_disk_encryption` | `bool` | Allow Disk Encryption to retrieve secrets from the vault and unwrap keys. Default: `false`. |
| `enabled_for_template_deployment` | `bool` | Allow Resource Manager to retrieve secrets from the Key Vault. Default: `false`. |
| `access_policies` | `list` | List of access policies for the Key Vault. |
| `secrets` | `map` | A map of secrets for the Key Vault. |
| `tags` | `map` | A mapping of tags to assign to the resource. |

The `access_policies` object can have the following keys:

| Name | Type | Description |
| --- | --- | --- |
| `group_names` | `list` | List of names of Azure AD groups. |
| `object_ids` | `list` | List of object IDs of Azure AD users, security groups or service principals. |
| `user_principal_names` | `list` | List of user principal names of Azure AD users. |
| `certificate_permissions` | `list` |  List of certificate permissions. The options are: `backup`, `create`, `delete`, `deleteissuers`, `get`, `getissuers`, `import`, `list`, `listissuers`, `managecontacts`, `manageissuers`, `purge`, `recover`, `restore`, `setissuers` and `update`. |
| `key_permissions` | `list` | List of key permissions. The options are: `backup`, `create`, `decrypt`, `delete`, `encrypt`, `get`, `import`, `list`, `purge`, `recover`, `restore`, `sign`, `unwrapkey`, `update`, `verify` and `wrapkey`. |
| `secret_permissions` | `list` | List of secret permissions. The options are: `backup`, `delete`, `get`, `list`, `purge`, `recover`, `restore` and `set`. |
| `storage_permissions` | `list` | List of storage permissions. The options are: `backup`, `delete`, `deletesas`, `get`, `getsas`, `list`, `listsas`, `purge`, `recover`, `regeneratekey`, `restore`, `set`, `setsas` and `update`. |


Secret files
------------

    ```
-	secret.json : stores the credential to write in Infra. Create the file in the directory Deploy/appgw/secret/secret.json
    - Content sample ==>
    ```json
        {
            "tenant_id"        : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "subscription_id"  : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "submsdn_id"       : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "client_id"        : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "client_secret"    : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            "key"            : "xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        }
    ```

Sample usage
-----

This step ensures that Terraform has all the prerequisites to build your template in Azure.
```hcl

execute TF commands from "test" directory 

terraform init -backend-config="../secret/secret.json" -input=false -reconfigure

terraform workspace new dev
# terraform workspace list
# terraform workspace select dev
# terraform workspace delete -force dev

terraform plan -var-file="../secret/secret.json" -out dev-azkv.tfplan -input=false

terraform apply "dev-azkv.tfplan"

terraform destroy -var-file="./variable/dev-azkv.tfvars" -var-file="./secret/secret.json" -auto-approve


```