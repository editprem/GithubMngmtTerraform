### To create Org Base or Parent Team ###
module "team" {
  source = "../modules/editprem-github-teams-module"
  for_each = {
    for keys in local.org_team_name :
    keys.name => keys
  }
  name                      = each.key
  description               = each.value.description
  privacy                   = var.team_privacy
  create_default_maintainer = var.create_default_maintainer
  members                   = local.gh_user_id
}

# All teams must be nested under the Org team 
# in order to have Consistencty for access management.
module "child_team" {
  source     = "../modules/editprem-github-teams-module"
  depends_on = [module.team]

  for_each = {
    for keys in local.nested_team_names :
    keys.name => keys
  }
  name           = each.key
  description    = each.value.description
  parent_team_id = data.github_team.org_id.id
  privacy        = var.team_privacy
  members = flatten([
    for e in local.user.GitHubUser : [
      for key, value in e : [
        value
      ] if key == "id" && e.teamSlug == "${each.key}"
    ]
  ])
}

### Module for creation of public repository ###
module "repository-public" {
  source = "../modules/editprem-github-repos-module"
  for_each = {
    for keys in local.public_repo_name :
    keys.name => keys
  }

  name               = each.key
  description        = each.value.description
  visibility         = var.repository_visibility
  archive_on_destroy = false


  branch_protections = [
    {
      branch                          = "main"
      enforce_admins                  = true
      require_conversation_resolution = false
      require_signed_commits          = false

      #   required_status_checks = {
      #     strict   = false
      #     contexts = ["ci/travis"]
      #   }

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        required_approving_review_count = 1
      }
    }
  ]
}

### Module for creation of private repository ###
module "repository-private" {
  source = "../modules/editprem-github-repos-module"
  for_each = {
    for keys in local.private_repo_name :
    keys.name => keys
  }

  name               = each.key
  description        = each.value.description
  archive_on_destroy = false
  # Uncomment if having teams subscription for Github.

  # branch_protections = [
  #   {
  #     branch                          = "main"
  #     enforce_admins                  = true
  #     require_conversation_resolution = false
  #     require_signed_commits          = false

  #     # required_status_checks = {
  #     #   strict   = true
  #     #   contexts = [""]
  #     # }

  #     required_pull_request_reviews = {
  #       dismiss_stale_reviews           = true
  #       required_approving_review_count = 1
  #     }
  #   }
  # ]
}
