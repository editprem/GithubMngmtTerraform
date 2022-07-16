# ---------------------------------------------------------------------------------------------------------------------
# CREATE A GITHUB TEAM and CHILD TEAM
#
# Create a Github team and child teams
# Default teams: editempremorg, admin, devops, developer, business
# ---------------------------------------------------------------------------------------------------------------------

resource "github_team" "team" {
  count                     = var.module_enabled ? 1 : 0
  name                      = var.name
  description               = var.description
  privacy                   = var.privacy
  parent_team_id            = var.parent_team_id
  ldap_dn                   = var.ldap_dn
  create_default_maintainer = var.create_default_maintainer
}

locals {
  maintainers = { for i in var.maintainers : lower(i) => { role = "maintainer", username = i } }
  members     = { for i in setsubtract(var.members, var.maintainers) : lower(i) => { role = "member", username = i } }

  memberships = merge(local.maintainers, local.members)
}

resource "github_team_membership" "team_membership" {
  for_each = var.module_enabled ? local.memberships : {}

  team_id  = try(github_team.team[0].id, null)
  username = each.value.username
  role     = each.value.role
}

resource "github_membership" "membership_for_user" {
  for_each = var.module_enabled ? local.memberships : {}
  username = each.value.username
  role     = var.github_membership_role
}