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
