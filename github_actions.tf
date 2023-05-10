resource "chainguard_group" "dogfood-group" {
  name        = "gha-signing-group"
  description = "A group to hold sigstore resources in"
  parent_id   = var.github_actions_group_id
}

# Look up the id for the sigstore.create role within this environment.
data "chainguard_roles" "editor" {
  name = "signing.editor"
}
# Create the identity we will assume to push images from actions.
resource "chainguard_identity" "actions-signer" {
  parent_id   = chainguard_group.dogfood-group.id
  name        = "actions signer"
  description = <<EOF
    This is the identity that we will assume from github actions to sign images.
  EOF

  claim_match {
    issuer  = "https://token.actions.githubusercontent.com"
    # Work on any branch
    subject_pattern = "repo:priyawadhwa/.*"
  }
}

# Emit the identity's ID so that we know what to assume in actions.
output "signer-identity" {
  value = chainguard_identity.actions-signer.id
}

# Grant the identity the "registry.pus" role on our root group.
resource "chainguard_rolebinding" "sign-stuff" {
  identity = chainguard_identity.actions-signer.id
  group    = chainguard_group.dogfood-group.id
  role     = data.chainguard_roles.editor.items[0].id
}
