output "provider_id" {
  value       = google_iam_workload_identity_pool_provider.chainguard_provider.name
  description = "GCP identity provider pool configured for Enforce"
}

output "hostname" {
  value = chainguard_sigstore.sigstore_ca.hostname
}

output "ca_name" {
  value = google_privateca_certificate_authority.ca.name
}