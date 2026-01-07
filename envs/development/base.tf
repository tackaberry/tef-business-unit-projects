
locals {

  activate_apis = [
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "essentialcontacts.googleapis.com",
    "assuredworkloads.googleapis.com",
    "cloudasset.googleapis.com",
    "cloudidentity.googleapis.com",
    "networksecurity.googleapis.com"
  ]

    org_roles =[
      "roles/resourcemanager.organizationViewer",
      "roles/serviceusage.serviceUsageConsumer",
      "roles/iam.securityReviewer",
    ]
    folder_roles = [
      "roles/resourcemanager.folderAdmin",
    #   "roles/artifactregistry.admin",
      "roles/compute.networkAdmin",
    #   "roles/compute.xpnAdmin",
      "roles/iam.serviceAccountAdmin",
      "roles/resourcemanager.projectDeleter",
      "roles/resourcemanager.projectCreator",
    ]
    project_roles = [
      "roles/storage.admin",
      "roles/iam.serviceAccountAdmin",
      "roles/compute.networkAdmin", # create project networking
    #   "roles/resourcemanager.projectDeleter",
    #   "roles/cloudkms.admin",
    ]
    
}

resource "google_project" "seed_project" {
  name                = "${local.project_prefix}-seed-project"
  project_id          = "${local.project_prefix}-seed-project-${random_string.suffix.result}"
  folder_id           = local.parent_folder_name
  billing_account     = local.billing_account
  auto_create_network = false
}

resource "google_project_service" "activate_apis" {
  for_each           = toset(local.activate_apis)
  project            = google_project.seed_project.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_storage_bucket" "tfstate_bucket" {
  name          = "bkt-${local.project_prefix}-tfstate"
  project      = google_project.seed_project.project_id
  location      = local.region
  force_destroy = true

  uniform_bucket_level_access = true

}

resource "google_service_account" "terraform_sa" {
  project      = google_project.seed_project.project_id
  account_id   = "sa-terraform-${random_string.suffix.result}"
  display_name = "Terraform Service Account"
}


resource "google_organization_iam_member" "org_parent_iam" {
  for_each = toset(local.org_roles)

  org_id = local.organization
  role   = each.key
  member = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_folder_iam_member" "folder_parent_iam" {
  for_each = toset(local.folder_roles)

  folder = local.parent_folder_name
  role   = each.key
  member = "serviceAccount:${google_service_account.terraform_sa.email}"
}

resource "google_project_iam_member" "project_parent_iam" {
  for_each = toset(local.project_roles)

  project = google_project.seed_project.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.terraform_sa.email}"
}


# resource "google_billing_account_iam_member" "tf_billing_user" {

#   billing_account_id = local.billing_account
#   role               = "roles/billing.user"
#   member             = "serviceAccount:${google_service_account.terraform_sa.email}"

#   depends_on = [
#     google_service_account.terraform_sa
#   ]
# }

# resource "google_billing_account_iam_member" "billing_admin_user" {

#   billing_account_id = local.billing_account
#   role               = "roles/billing.admin"
#   member             = "serviceAccount:${google_service_account.terraform_sa.email}"

#   depends_on = [
#     google_billing_account_iam_member.tf_billing_user
#   ]
# }
# resource "google_billing_account_iam_member" "billing_account_sink" {
#   billing_account_id = local.billing_account
#   role               = "roles/logging.configWriter"
#   member             = "serviceAccount:${google_service_account.terraform_sa.email}"
# }
