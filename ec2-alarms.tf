resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count                     = var.high_cpu_enabled ? 1 : 0
  alarm_name                = "high-cpu-${var.ec2_instance_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = var.high_cpu_threshold
  alarm_description         = "Average EC2 CPU utilization IN ${var.ec2_instance_name} is too high"
  alarm_actions             = [var.aws_sns_topic_arn]
  ok_actions                = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  treat_missing_data        = "breaching"
  datapoints_to_alarm       = 5
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count                     = var.status_check_failed_enabled ? 1 : 0
  alarm_name                = "status-check-failed-${var.ec2_instance_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = var.status_check_failed_count
  alarm_description         = "Status check failed IN ${var.ec2_instance_id}"
  alarm_actions             = [var.aws_sns_topic_arn]
  ok_actions                = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count                     = var.high_memory_enabled ? 1 : 0
  alarm_name                = "high-memory-${var.ec2_instance_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "mem_used_percent"
  namespace                 = var.namespace
  period                    = "300"
  statistic                 = "Average"
  threshold                 = var.high_memory_threshold
  alarm_description         = "Average memory IN ${var.ec2_instance_id} is too high"
  alarm_actions             = [var.aws_sns_topic_arn]
  ok_actions                = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_disk" {
  for_each                  = { for idx, disk in var.disk_usage_thresholds : "${disk.path}-${disk.device}-${disk.fstype}" => disk }
  alarm_name                = "high-disk-${var.ec2_instance_name}-${each.value.path}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "disk_used_percent"
  namespace                 = var.namespace
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = each.value.threshold
  alarm_actions             = [var.aws_sns_topic_arn]
  ok_actions                = [var.aws_sns_topic_arn]
  insufficient_data_actions = [var.aws_sns_topic_arn]
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
    device     = each.value.device
    fstype     = each.value.fstype
    path       = each.value.path
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

  alarm_description = "Disk usage in ${var.ec2_instance_name} on ${each.value.path} is too high"
}
