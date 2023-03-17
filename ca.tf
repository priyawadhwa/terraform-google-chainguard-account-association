locals {
  cn = "signing-dogfooding"
  o  = "chainguard.dev"

}

resource "google_privateca_ca_pool" "ca_pool" {
  name = "signing-dogfooding"

  project  = "priya-chainguard"
  location = "us-central1"
  tier     = "DEVOPS"

  publishing_options {
    publish_ca_cert = false
    publish_crl     = false
  }

  issuance_policy {
    allowed_issuance_modes {
      allow_csr_based_issuance    = true
      allow_config_based_issuance = true
    }

    identity_constraints {
      allow_subject_passthrough           = true
      allow_subject_alt_names_passthrough = true
    }

    baseline_values {
      aia_ocsp_servers = []

      ca_options {
        is_ca                       = false
        max_issuer_path_length      = 0
        non_ca                      = false
        zero_max_issuer_path_length = false
      }

      key_usage {
        base_key_usage {
          cert_sign          = false
          content_commitment = false
          crl_sign           = false
          data_encipherment  = false
          decipher_only      = false
          digital_signature  = false
          encipher_only      = false
          key_agreement      = false
          key_encipherment   = false
        }

        extended_key_usage {
          client_auth      = false
          code_signing     = false
          email_protection = false
          ocsp_signing     = false
          server_auth      = false
          time_stamping    = false
        }
      }
    }
  }
}

resource "google_privateca_certificate_authority" "ca" {
  project  = "priya-chainguard"
  location = "us-central1"
  pool     = google_privateca_ca_pool.ca_pool.name

  certificate_authority_id = "signing-dogfooding-ca"
  deletion_protection      = false


  config {
    subject_config {
      subject {
        organization = local.o
        common_name  = local.cn
      }
    }
    x509_config {
      ca_options {
        is_ca = true
        max_issuer_path_length = 10
      }
      key_usage {
        base_key_usage {
          digital_signature = true
          content_commitment = true
          key_encipherment = false
          data_encipherment = true
          key_agreement = true
          cert_sign = true
          crl_sign = true
          decipher_only = true
        }
        extended_key_usage {
          server_auth = true
          client_auth = false
          email_protection = true
          code_signing = true
          time_stamping = true
        }
      }
    }
  }
  lifetime = "315360000s" # 10 years
  key_spec {
    algorithm = "EC_P256_SHA256"
  }
}
