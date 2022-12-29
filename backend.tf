terraform {
  backend "gcs" {
    bucket = "priya-chainguard-terraform-state"
    prefix = "terraform/state/terraform-google-chainguard-account-association"
  }
}