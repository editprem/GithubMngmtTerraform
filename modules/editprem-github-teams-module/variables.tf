# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether or not to create resources within the module."
  default     = true
}

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "(Required) The name of the team."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "(Optional) A description of the team."
  type        = string
  default     = "Please change this default teams description."
}

variable "privacy" {
  description = "(Optional) The level of privacy for the team. Must be one of secret or closed."
  type        = string
  default     = "secret"
}

variable "parent_team_id" {
  description = "(Optional) The ID of the parent team, if this is a nested team."
  type        = number
  default     = null
}

variable "ldap_dn" {
  description = "(Optional) The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise."
  type        = string
  default     = null
}

variable "create_default_maintainer" {
  type        = string
  description = "(Optional) Adds the creating user to the team when set to `true`."
  default     = false
}

variable "maintainers" {
  description = "(Optional) A list of users that will be added to the current team with maintainer permissions."
  type        = set(string)
  default     = []
}

variable "members" {
  description = "(Optional) A list of users that will be added to the current team with member permissions."
  type        = set(string)
  default     = []
}

variable "github_membership_role" {
  description = "(Optional) The role of the user within the organization. Must be one of member or admin. Defaults to member"
  type = string
  default = "member"
}
