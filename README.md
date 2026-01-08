
# Terraform Project

## Initial Setup

1. Clone the repository:

```bash
git clone <your-repository-url>
```

2. Authenticate with Google Cloud:

```bash
gcloud auth application-default login
gcloud auth login
```

3. Initialize, plan, and apply Terraform:

```bash
./tf-wrapper.sh init development
./tf-wrapper.sh plan development
./tf-wrapper.sh apply development
```

4. Get the Terraform output:
```bash
terraform -chdir="./envs/development/" output
```

## Backend Migration

1. Migrate backend to a GCS bucket:


```bash
cp envs/development/backend.tf.example envs/development/backend.tf
```

2. Edit `envs/development/backend.tf` and replace `your-bucket-name` with the name of your GCS bucket.

3. Initialize Terraform to migrate the backend:
```bash
terraform -chdir="./envs/development/" init
# Type "yes" to approve the backend migration.
```

## Service Account Impersonation

1. If needed, add `iam.serviceAccountTokenCreator` to user impersonating service account. 


```bash
export ADMIN_USER=$(gcloud auth list --filter=status:ACTIVE --format="value(account)")
export SEED_PROJECT_ID=$(terraform -chdir="./envs/development/" output -raw seed_project_id)
export SERVICE_ACCOUNT=$(terraform -chdir="./envs/development/" output -raw service_account)

gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT \
    --member="user:$ADMIN_USER" \
    --role="roles/iam.serviceAccountUser" \
    --project=$SEED_PROJECT_ID
gcloud iam service-accounts add-iam-policy-binding $SERVICE_ACCOUNT \
    --member="user:$ADMIN_USER" \
    --role="roles/iam.serviceAccountTokenCreator" \
    --project=$SEED_PROJECT_ID
```

## Set Default Service Account

1. Set the `GOOGLE_IMPERSONATE_SERVICE_ACCOUNT` environment variable to use the service account for authentication.

```bash
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=$SERVICE_ACCOUNT
```