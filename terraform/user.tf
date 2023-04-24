# Create the test user.  We do not require SSM Parameter Store access
# for this role, so we can simply use cisagov/ci-iam-user-tf-module
# instead of cisagov/molecule-iam-user-tf-module.
module "user" {
  source = "github.com/cisagov/ci-iam-user-tf-module"

  providers = {
    aws            = aws.users
    aws.production = aws.images_production_provisionaccount
    aws.staging    = aws.images_staging_provisionaccount
  }

  role_description = "A role that can be assumed to allow for CI testing of ansible-role-crowdstrike via Molecule."
  role_name        = "Test-ansible-role-crowdstrike"
  user_name        = "test-ansible-role-crowdstrike"
}

# Attach third-party S3 bucket read-only policy to the production
# role used by the test user
resource "aws_iam_role_policy_attachment" "thirdpartybucketread_production" {
  provider = aws.images_production_provisionaccount

  policy_arn = module.production_bucket_access.policy.arn
  role       = module.user.production_role.name
}

# Attach third-party S3 bucket read-only policy to the staging
# role used by the test user
resource "aws_iam_role_policy_attachment" "thirdpartybucketread_staging" {
  provider = aws.images_staging_provisionaccount

  policy_arn = module.staging_bucket_access.policy.arn
  role       = module.user.staging_role.name
}

# Attach 3rd party S3 bucket read-only policy from
# cisagov/ansible-role-cdm-certificates to the production role used by
# the test user
resource "aws_iam_role_policy_attachment" "thirdpartybucketread_certificates_production" {
  provider = aws.images_production_provisionaccount

  policy_arn = data.terraform_remote_state.ansible_role_cdm_certificates.outputs.production_bucket_policy.arn
  role       = module.user.production_role.name
}

# Attach 3rd party S3 bucket read-only policy from
# cisagov/ansible-role-cdm-certificates to the staging role used by
# the test user
resource "aws_iam_role_policy_attachment" "thirdpartybucketread_certificates_staging" {
  provider = aws.images_staging_provisionaccount

  policy_arn = data.terraform_remote_state.ansible_role_cdm_certificates.outputs.staging_bucket_policy.arn
  role       = module.user.staging_role.name
}
