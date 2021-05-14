terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
    project = "${var.gcp_proj}"
    region  = var.region
    zone    = var.default_zone
}