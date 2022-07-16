### Local variables for Team Modules ###
locals {
  ou_config = yamldecode(file("../yaml/teams.yaml"))

  org_team_name = flatten([
    for e in local.ou_config.Teams : [
      for key, person in e : [
        for key, value in person : [
          value
        ]
      ] if key == "OrgTeam"
    ]
  ])

  nested_team_names = flatten([
    for e in local.ou_config.Teams : [
      for key, person in e : [
        for key, value in person : [
          value
        ]
      ] if key == "NestedTeam"
    ]
  ])
}

### Local variables for repository module ####
locals {
  repo_location = yamldecode(file("../yaml/repo.yaml"))

  public_repo_name = flatten([
    for e in local.repo_location.Repository : [
      for key, person in e : [
        for key, value in person : [
          value
        ]
      ] if key == "Public"
    ]
  ])

  private_repo_name = flatten([
    for e in local.repo_location.Repository : [
      for key, person in e : [
        for key, value in person : [
          value
        ]
      ] if key == "Private"
    ]
  ])
}

### Local variables for team membership module ####
locals {
  user = yamldecode(file("../yaml/user.yaml"))

  gh_user_id = flatten([
    for e in local.user.GitHubUser : [
      for key, value in e : [
        value
      ] if key == "id"
    ]
  ])

  gh_devops_user_id = flatten([
    for e in local.user.GitHubUser : [
      for key, value in e : [
        value
      ] if key == "id" && e.teamSlug == "developer"
    ]
  ])
}
