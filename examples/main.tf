provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "sns_topic" {
  name         = "sns"
  display_name = "sns"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.sns_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.sns.com/v1/xxx"
  depends_on                      = [aws_sns_topic.sns_topic]
}

module "ec2-cloudwatch-alarms" {
  source            = "deliveroo/ec2-alarms/aws"
  ec2_instance_id   = var.ec2_instance_id
  aws_sns_topic_arn = aws_sns_topic.sns_topic.arn
  disk_usage_thresholds = [
    {
      path      = "/"
      device    = "/dev/xvda1"
      fstype    = "xfs"
      threshold = 90
    },
    {
      path      = "/mnt"
      device    = "/dev/xvdb"
      fstype    = "xfs"
      threshold = 90
    }
  ]
  high_cpu_enabled    = false
  high_memory_enabled = false
  depends_on = [aws_sns_topic.sns_topic]

}




