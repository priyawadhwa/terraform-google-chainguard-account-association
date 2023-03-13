resource "chainguard_sigstore" "sigstore_ca" {
  name        = "terraform-ca"
  parent_id   = var.github_actions_group_id
  description = "CA created by terraform"
  google_ca {
    ref = "projects/priya-chainguard/locations/us-west1/caPools/priya-sigstore/certificateAuthorities/sigstore-authority"
  }
}
