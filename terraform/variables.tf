##### VARIABLE for Team Module #####
variable "team_privacy" {
  description = "The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "closed"
}

variable "create_default_maintainer" {
  type        = string
  description = "(Optional) Adds the creating user to the team when set to `true`."
  default     = true
}

##### VARIABLE for Repo Module #####
variable "repository_visibility" {
  description = "(Optional) Can be 'public', 'private'"
  type        = string
  default     = "public"
}