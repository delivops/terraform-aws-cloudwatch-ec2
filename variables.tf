variable "high_cpu_threshold" {
  description = "The threshold for high CPU usage"
  type        = number
  default     = 90

}
variable "high_cpu_enabled" {
  description = "Enable high CPU alarm"
  type        = bool
  default     = true

}
variable "status_check_failed_enabled" {
  description = "Enable status check failed alarm"
  type        = bool
  default     = true

}
variable "status_check_failed_count" {
  description = "The number of failed status checks before the alarm is triggered"
  type        = number
  default     = 1

}
variable "ec2_instance_id" {
  description = "The instance ID of the EC2 instance that you want to monitor."
  type        = string
}
variable "ec2_instance_name" {
  description = "The name of the EC2 instance that you want to monitor."
  type        = string

}
variable "aws_sns_topics_arns" {
  description = "List of ARNs for the SNS topics"
  type        = list(string)
  default     = []

}
variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
variable "high_memory_enabled" {
  description = "Enable high memory alarm"
  type        = bool
  default     = true

}
variable "high_memory_threshold" {
  description = "The threshold for high memory usage"
  type        = number
  default     = 90

}
variable "high_disk_enabled" {
  description = "Enable high disk alarm"
  type        = bool
  default     = true

}
variable "disk_usage_thresholds" {
  description = "List of disk usage thresholds with path, device, and fstype"
  type = list(object({
    path      = string
    device    = string
    fstype    = string
    threshold = number
  }))
  default = []
}
variable "namespace" {
  description = "The namespace for the CloudWatch metric agent"
  type        = string
  default     = "CWAgent"

}
