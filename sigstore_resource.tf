resource "chainguard_sigstore" "sigstore_ca" {
  name        = "terraform-ca"
  parent_id   = "20c1263ac49f8cf9ad39e91006fa2beb8096e7f4"
  description = "CA created by terraform"
  google_ca {
    ref = "projects/priya-chainguard/locations/us-west1/caPools/priya-sigstore/certificateAuthorities/sigstore-test"
  }
}
