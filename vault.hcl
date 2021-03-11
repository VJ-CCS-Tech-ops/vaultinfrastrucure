# Listener
# 1.     Defines that is listening to all the ip’s
# 2.     Third party certificate with the client cert is stored and referenced here to allow Https request to Vault
# Note : It is good idea to copy the root ca and the cert in to vault.crt.  When you integrate other systems like Cloud Foundry or Ansible, You will face certificate verification

listener "tcp" {
 address= "0.0.0.0:8200"
      tls_cert_file = "/vault/userconfig/vault-server-tls/vault.crt"
      tls_key_file  = "/vault/userconfig/vault-server-tls/vault.key"
      tls_client_ca_file = "/vault/userconfig/vault-server-tls/vault.ca"
 }

 #Storage –
 # 1.     Integrated (raft) storage is used to simply the architecture and to provide HA
 # 2.     Identity of the node

storage "raft" {
  path = "/opt/data"
  node_id = "Vault-VM01"
}

# Azure key Vault –
# 1.     Vault is registered as a client and uses the client secret to store and retrieve the key
# 2.     Azure key vault replaces shamir key

seal "azurekeyvault" {
  client_id      = "80K63636-0219-4e80-893b-304bcb83882d"
  client_secret  = "NCkQ_8Dsk6g6UH1K~7J~7e9BO-y_ADKCd~"
  tenant_id      = "4f830d79-3e87-4cr3-9799-c3453146e55e"
  vault_name     = "AzK-Vault01"
  key_name       = "Vault"
}

# Other-
# 1.     Give vault the ability to use the mlock syscall without running the process as root. The mlock syscall prevents memory from being swapped to disk.
# 2.     User interface is enabled
# 3.     Api address is to mention the ip address to which the application listens

disable_mlock="true"
ui="true"
api_addr="http://10.0.0.4:8200"
cluster_addr=http://10.0.0.4:8201
