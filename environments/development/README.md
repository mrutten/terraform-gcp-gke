# Table of Contents

- [Table of Contents](#table-of-contents)
- [Authentication](#authentication)
- [Workspace](#workspace)
- [Authorization](#authorization)

# Authentication

Use gcloud's Application Default Credentials ("ADCs") to authenticate by executing the following steps.

`gcloud auth application-default login --disable-quota-project --no-launch-browser`

Copy the URL to the browser that is logged in as the identity you want to use to Terraform, then copy-paste the authorization code.

The credentials will be saved to ~/.config/gcloud/application_default_credentials.json and will be used by any library that requests Application Default Credentials (ADC).

> If the warning below pops up, ignore it. There is no quota project, since the project will be created by Terraform.  
> WARNING:   
> Quota project is disabled. You might receive a "quota exceeded" or "API not enabled" error. Run $ gcloud auth application-default set-quota-project to add a quota project.

# Workspace

In Google Workspace, create a group, e.g. terraform@example.com. Give this group the roles mentioned under authorization below.
You can then add Cloud Identities as members of this group.

# Authorization

Whatever identity is used to Terraform, be it a service account, user or group, it needs permissions to bootstrap the Terraform manifest. 
Therefore, the identity needs the following roles at the organizational level;

- Billing Account User - to associate a billing account with the project
- Compute Shared VPC Admin - Administer Shared VPC
- Organization Role Viewer - To view the organizational roles
- Project Creator - to create a project
- Project Deleter - to delete project with `terraform destroy`
- Project IAM Admin - to assign roles on the project level to the Terraform user
- Quota Viewer - to check whether quota is granted for a new project
- Service Usage Viewer - to view services

Any group that needs to login to Compute Engine over SSH, needs the following organizational roles:

- Compute OS Login External User
