variable "master_role_name" {
  description = "The name of the master node IAM role"
  type        = string
  default     = "ktb_11_chatbot_master_role"
}

variable "worker_role_name" {
  description = "The name of the worker node IAM role"
  type        = string
  default     = "ktb_11_chatbot_worker_role"
}
