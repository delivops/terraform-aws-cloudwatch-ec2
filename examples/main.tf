provider "aws" {
  region = "eu-west-1"
}

resource "aws_sns_topic" "opsgenie_topic" {
  name         = "opsgenie"
  display_name = "opsgenie"
}

resource "aws_sns_topic_subscription" "opsgenie_subscription" {
  confirmation_timeout_in_minutes = 1
  endpoint_auto_confirms          = false
  topic_arn                       = aws_sns_topic.opsgenie_topic.arn
  protocol                        = "https"
  endpoint                        = "https://api.opsgenie.com/v1/xxx"
  depends_on                      = [aws_sns_topic.opsgenie_topic]
}

module "i-023de0ca96508cbde-alarms" {
  source                   = "../"
  ec2_instance_id = "i-023de0ca96508cbde"
  aws_sns_topic_arn        = aws_sns_topic.opsgenie_topic.arn
  depends_on               = [aws_sns_topic.opsgenie_topic]

}




