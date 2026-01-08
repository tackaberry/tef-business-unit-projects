locals {
    env                = "development"
    project_prefix     = var.project_prefix

    parent_folder_name = var.parent_folder
    region = var.default_region
    organization = var.org_id

    identity_domain      = data.google_organization.org.domain
    projects = jsondecode(file("projects.json"))

    billing_account = var.billing_account

    regions = [
        var.default_region,
        "northamerica-northeast2"
    ]

}

data "google_organization" "org" {
  organization = local.organization
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# resource "google_assured_workloads_workload" "folder_db_pb" {
#   compliance_regime         = "DATA_BOUNDARY_FOR_CANADA_PROTECTED_B"
#   display_name              = "fldr-${local.project_prefix}-pb-${random_string.suffix.result}"
#   location                  = "ca"
#   organization              = local.organization
#   billing_account           = "billingAccounts/${local.billing_account}"
#   enable_sovereign_controls = true

#   provisioned_resources_parent = local.parent_folder_name

#   resource_settings {
#     resource_type = "CONSUMER_FOLDER"
#   }

#   provider                  = google-beta

# }