##### For Secret Teams Creations #####
locals {
  secret_config = yamldecode(file("secretTeams.yaml"))

  secret_team_names = flatten([
    for e in local.secret_config.Teams : [
      for key, person in e : [
        for key, value in person : [
          value
        ]
      ] if key == "SecretTeam"
    ]
  ])
}

module "secret_team" {
  source = "../modules/editprem-github-teams-module"
  for_each = {
    for keys in local.secret_team_names :
    keys.name => keys
  }
  name                      = each.key
  description               = each.value.description
  create_default_maintainer = var.create_default_maintainer
}