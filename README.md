
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

1. Set default service account.

```bash
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=$SERVICE_ACCOUNT
```