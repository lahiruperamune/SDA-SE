variable "lambda_role_name" {
  description = "Unique name for iam role. If omitted, Terraform will assign a random, unique name"
}

variable "lambda_function_name" {
  description = "Unique name for the Lambda Function."
}

variable "timeout" {
  description = "Amount of time the Lambda Function has to run in seconds."
  default     = 3
}

variable "event_rule_name" {
  description = "Unique name for rule. If omitted, Terraform will assign a random, unique name"
}

variable "schedule_expression" {
  description = "The scheduling expression"
  default     = "rate(5 minutes)"
}

variable "event_target_id" {
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
}
