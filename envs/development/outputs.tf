/**
 * Copyright 2025 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
 
output "created_projects" {
  description = "A map of the created projects and their details."
  value = {
    for key, project in module.projects : key => {
      name           = project.name
      project_id     = project.project_id
      project_number = project.project_number
    }
  }
}

output "seed_project_id" {
  description = "Seed project"
  value = google_project.seed_project.project_id
}

output "tfstate_bucket" {
  description = "Backend bucket to load Terraform Remote State Data from previous steps."
  value = google_storage_bucket.tfstate_bucket.name
}

output "service_account" {
  description ="Service account"
  value = google_service_account.terraform_sa.email
}
