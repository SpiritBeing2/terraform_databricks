resource_group_name  = "rg-demo-terraform-2"
resource_group_vault = "security"
location             = "France Central"
vault_name           = "vault457"
environment          = "int"

cluster = {
  spark_version = "3"
  node_type_id = "33"
  num_workers = 2
  autotermination_minutes = 2
}
