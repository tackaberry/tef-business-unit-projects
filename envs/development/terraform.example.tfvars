/**
 * Copyright 2023 Google LLC
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

org_id = "REPLACE_ME" # format "000000000000"

billing_account = "REPLACE_ME" # format "000000-000000-000000"

default_region = "northamerica-northeast1"
#default_region = "northamerica-northeast2"

# Optional - for an organization with existing projects or for development/validation.
# Uncomment this variable to place all the example foundation resources under
# the provided folder instead of the root organization.
# The variable value is the numeric folder ID
# The folder must already exist.
parent_folder = "01234567890"

/* ----------------------------------------
    Specific to azure devops
   ---------------------------------------- */
# azure_devops_config = {
#   allowed_audiences = [ "https://management.azure.com/" ]
#   app_id = "" # app object id in entra
#   issuer_uri = "https://sts.windows.net/tenantid" # azure tenant id
#   bootstrap = "gcp-bootstrap"
#   org = "gcp-org"
#   env = "gcp-env"
#   net = "gcp-networks"
#   proj = "gcp-projects"
# }
