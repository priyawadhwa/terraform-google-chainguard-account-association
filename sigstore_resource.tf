resource "chainguard_sigstore" "sigstore_ca" {
  name        = "terraform-ca"
  parent_id   = chainguard_group.dogfood-group.id
  description = "CA created by terraform"
  google_ca {
    ref = "projects/priya-chainguard/locations/us-west1/caPools/priya-sigstore/certificateAuthorities/sigstore-authority"
  }
}

resource "chainguard_sigstore" "sigstore_ca_tf" {
  name        = "terraform-ca-2"
  parent_id   = chainguard_group.dogfood-group.id
  description = "CA created by terraform"
  google_ca {
    ref = google_privateca_certificate_authority.ca.name
  }
}
