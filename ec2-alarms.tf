resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  count               = var.high_cpu_enabled ? 1 : 0
  alarm_name          = "${var.ec2_instance_id}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.high_cpu_threshold
  alarm_description   = "Average EC2 CPU utilization IN ${var.ec2_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  datapoints_to_alarm = 5
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count               = var.status_check_failed_enabled ? 1 : 0
  alarm_name          = "${var.ec2_instance_id}-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  datapoints_to_alarm = 5
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.status_check_failed_count
  alarm_description   = "Average database Memory utilization IN ${var.ec2_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}



resource "aws_cloudwatch_metric_alarm" "high_memory" {
  count               = var.high_memory_enabled ? 1 : 0
  alarm_name          = "${var.ec2_instance_id}-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_used_percent"
  namespace           = "AWS/CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.high_memory_threshold
  alarm_description   = "Average memory IN ${var.ec2_instance_id} is too high"
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]

  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })

}

resource "aws_cloudwatch_metric_alarm" "high_disk" {
  count               = var.high_disk_enabled ? 1 : 0
  alarm_name          = "${var.ec2_instance_id}-high-disk"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "mem_used_percent"
  namespace           = "AWS/CWAgent"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.high_disk_threshold
  alarm_actions       = [var.aws_sns_topic_arn]
  ok_actions          = [var.aws_sns_topic_arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = merge(var.tags, {
    "InstanceId" = var.ec2_instance_id,
    "Terraform"  = "true"
  })


  alarm_description = "Write Disk IN ${var.ec2_instance_id} is too high"

}
