resource "chainguard_sigstore" "sigstore_ca" {
  name        = "terraform-ca"
  parent_id   = "66fe2f6b69fb795e63abc2769c294ee0d049ee0a"
  description = "CA created by terraform"
  google_ca {
    ref = "projects/priya-chainguard/locations/us-west1/caPools/priya-sigstore/certificateAuthorities/sigstore-test"
  }
}
