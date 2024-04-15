# AWS provider configuration
provider "aws" {
  region = "us-east-1"
}

# Vault provider configuration
provider "vault" {
  address = "http://100.26.178.240:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"
    method = "approle"

    parameters = {
      role_id = "cfc24509-22c7-b363-13c2-ba687ca6ee5b"
      secret_id = "7d684449-8530-a6a0-0a55-d566335b2881"
    }
  }
}

# Vault KV secret data source
data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "test-secret"
}

# AWS instance resource
resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name   = "test-instance"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
