terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
    }
    google = {
      source = "hashicorp/google"
    }
    chainguard = {
      source = "chainguard/chainguard"
    }
  }
}


provider "chainguard" {
  console_api = "https://console-api.priya-chainguard.dev"
}
