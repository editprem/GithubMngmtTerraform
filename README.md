## Editprem Teams & Repos
### Editeprem Teams
- Token must have the repo, org and delete access.
```
export GITHUB_TOKEN=XXXXXxxxXXXxx
export GITHUB_OWNER=editprem
```
***Initialise Terrafrom:***
```
git clone <repo_ssh_url>
cd <repoName>/terrafrom
terraform init
```
***To create Base Org Team:***
- Add team's name and description in `teams.yaml` on `OrgTeam`
- Make sure all entry in small letters to avoid mismatch in team slug
- Add the same in `data.tf` in `slug = <Name>`
- By default, All users present in the `user.yaml` are in this base team with `Read Access` in organization.
```
terraform plan --target=module.team
```
***To create new child teams:***
- All the teams here, are nested in organization base team.
- Add team's name and description in `teams.yaml` on `NestedTeam`
- It is important to note that any user can have only one of these teams:
  - admin
  - devops
  - developer
  - business
- Map user to the new team in `user.yaml`. These users will have write access by default for the repos.
- If you don't map the user to any team, By default they will have `read access only`. This is good for Interns for few weeks or temperory third-party access.
```
terraform plan --target=module.child_team
```

> Don't touch the `secretTeams` until you know what you are doing.

___________________________________________

### Editeprem Repository
***To create new Repositories:***
- We can create 2 kind of repository for our organization:
  - Public Repository
  - Private Repository

- Add details for repo in `repo.yaml` file.
```
terraform plan --target=module.repository-public
terraform plan --target=module.repository-private
```
- Remove `archive_on_destroy = false` from `modules.tf` if you want to preserve the repository being deleted immediately.
- Private repository needs paid plan of github to apply the branch protection rules.

___________________________________________

### User Management
***To invite new user:***
- Users/Members can only be invited through team membership.
- Add user GitHub ID in the `user.yaml` along with team he is joining.
> Note that we've only 4 teams in our Organization.
- If user is mapped to no teams, He'll only have read access by default.
```
terraform plan
```
***To remove user:***
- Remove team member id and slug if person leaves the Org on the LWD.
```
terraform plan
```
 