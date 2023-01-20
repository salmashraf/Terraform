provider "aws" {
  region = var.region
  shared_config_files = var.config
  shared_credentials_files = var.credentials
  profile = "dev-user"
}