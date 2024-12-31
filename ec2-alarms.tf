resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count                     = var.high_cpu_enabled ? 1 : 0
  alarm_name                = "EC2 | High CPU Utilization (>${var.high_cpu_threshold}%) | ${var.ec2_instance_name}"
  alarm_description         = "High CPU in ${var.ec2_instance_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = var.high_cpu_threshold
  alarm_actions             = concat(var.high_cpu_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.high_cpu_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.high_cpu_sns_arns, var.all_alarms_sns_arns)
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  count                     = var.low_cpu_enabled ? 1 : 0
  alarm_name                = "EC2 | Low CPU Utilization (>${var.low_cpu_threshold}%) | ${var.ec2_instance_name}"
  alarm_description         = "Low CPU in ${var.ec2_instance_name}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = var.low_cpu_threshold
  alarm_actions             = concat(var.low_cpu_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.low_cpu_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.low_cpu_sns_arns, var.all_alarms_sns_arns)
  treat_missing_data        = "breaching"
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
  alarm_name                = "EC2 | Status Check Failed (>${var.status_check_failed_count}) | ${var.ec2_instance_name}"
  alarm_description         = "Status check failed in ${var.ec2_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "StatusCheckFailed"
  namespace                 = "AWS/EC2"
  period                    = 60
  statistic                 = "Average"
  threshold                 = var.status_check_failed_count
  alarm_actions             = concat(var.status_check_failed_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.status_check_failed_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.status_check_failed_sns_arns, var.all_alarms_sns_arns)
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
  alarm_name                = "EC2 | High Memory Utilization (>${var.high_memory_threshold}%) | ${var.ec2_instance_name}"
  alarm_description         = "High memory in ${var.ec2_instance_id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "mem_used_percent"
  namespace                 = var.namespace
  period                    = "300"
  statistic                 = "Average"
  threshold                 = var.high_memory_threshold
  alarm_actions             = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.high_memory_sns_arns, var.all_alarms_sns_arns)
  treat_missing_data        = "breaching"
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}
resource "aws_cloudwatch_metric_alarm" "low_memory" {
  count                     = var.low_memory_enabled ? 1 : 0
  alarm_name                = "EC2 | Low Memory Utilization (>${var.low_memory_threshold}%) | ${var.ec2_instance_name}"
  alarm_description         = "Low memory in ${var.ec2_instance_id}"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "mem_used_percent"
  namespace                 = var.namespace
  period                    = "300"
  statistic                 = "Average"
  threshold                 = var.low_memory_threshold
  alarm_actions             = concat(var.low_memory_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.low_memory_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.low_memory_sns_arns, var.all_alarms_sns_arns)
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
  alarm_name                = "EC2 | High Disk Utilization (>${each.value.threshold}%) | ${var.ec2_instance_name}/${each.value.path}"
  alarm_description         = "High Disk usage in ${var.ec2_instance_name}/${each.value.path}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  metric_name               = "disk_used_percent"
  namespace                 = var.namespace
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = each.value.threshold
  alarm_actions             = concat(var.high_disk_sns_arns, var.all_alarms_sns_arns)
  ok_actions                = concat(var.high_disk_sns_arns, var.all_alarms_sns_arns)
  insufficient_data_actions = concat(var.high_disk_sns_arns, var.all_alarms_sns_arns)
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

}
