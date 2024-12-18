![image info](logo.jpeg)

# terraform-aws-cloudwatch-ec2

This Terraform module provisions alarms using aws cloudwatch for monitoring and notification EC2. The module allows you to create alerts based on various performance metrics of your EC2, helping you to proactively manage and respond to potential issues in your EC2.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create cloudwatch alarms for your EC2. You can use this module multiple times to create alarms with different configurations for various instances or metrics.

```python


################################################################################
# Cloudwatch Alarms for EC2
################################################################################

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
  source            = "delivops/cloudwatch-ec2/aws"
  #version           = "0.0.11"

  ec2_instance_id   = var.ec2_instance_id
  ec2_instance_name = var.ec2_instance_name
  global_sns_topics_arns = [aws_sns_topic.sns_topic.arn]
  namespace         = "CWAgent"
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
  depends_on          = [aws_sns_topic.sns_topic]

}

```

## information

1. high cpu- with threshold:
   You enter the threshold for CPU, for example 80%. In case of alerts, the solution will be increasing the cpu of your instance.

2. high memory- with threshold:
   You enter the threshold for Memory, for example 80%. You are also enter the memory allocate for your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the memory of your instance.
3. high disk- with threshold:
   You enter the threshold for disk, with the path, device and fstype of the disk.

## License

MIT

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                   | Version   |
| ------------------------------------------------------ | --------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 4.67.0 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 5.78.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                   | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- |
| [aws_cloudwatch_metric_alarm.high_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)            | resource |
| [aws_cloudwatch_metric_alarm.high_disk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)           | resource |
| [aws_cloudwatch_metric_alarm.high_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm)         | resource |
| [aws_cloudwatch_metric_alarm.status_check_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name                                                                                                               | Description                                                      | Type                                                                                                                   | Default     | Required |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ----------- | :------: |
| <a name="input_aws_sns_topics_arns"></a> [aws_sns_topics_arns](#input_aws_sns_topics_arns)                         | List of ARNs for the SNS topics                                  | `list(string)`                                                                                                         | `[]`        |    no    |
| <a name="input_disk_usage_thresholds"></a> [disk_usage_thresholds](#input_disk_usage_thresholds)                   | List of disk usage thresholds with path, device, and fstype      | <pre>list(object({<br/> path = string<br/> device = string<br/> fstype = string<br/> threshold = number<br/> }))</pre> | `[]`        |    no    |
| <a name="input_ec2_instance_id"></a> [ec2_instance_id](#input_ec2_instance_id)                                     | The instance ID of the EC2 instance that you want to monitor.    | `string`                                                                                                               | n/a         |   yes    |
| <a name="input_ec2_instance_name"></a> [ec2_instance_name](#input_ec2_instance_name)                               | The name of the EC2 instance that you want to monitor.           | `string`                                                                                                               | n/a         |   yes    |
| <a name="input_high_cpu_enabled"></a> [high_cpu_enabled](#input_high_cpu_enabled)                                  | Enable high CPU alarm                                            | `bool`                                                                                                                 | `true`      |    no    |
| <a name="input_high_cpu_threshold"></a> [high_cpu_threshold](#input_high_cpu_threshold)                            | The threshold for high CPU usage                                 | `number`                                                                                                               | `90`        |    no    |
| <a name="input_high_disk_enabled"></a> [high_disk_enabled](#input_high_disk_enabled)                               | Enable high disk alarm                                           | `bool`                                                                                                                 | `true`      |    no    |
| <a name="input_high_memory_enabled"></a> [high_memory_enabled](#input_high_memory_enabled)                         | Enable high memory alarm                                         | `bool`                                                                                                                 | `true`      |    no    |
| <a name="input_high_memory_threshold"></a> [high_memory_threshold](#input_high_memory_threshold)                   | The threshold for high memory usage                              | `number`                                                                                                               | `90`        |    no    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                                                       | The namespace for the CloudWatch metric agent                    | `string`                                                                                                               | `"CWAgent"` |    no    |
| <a name="input_status_check_failed_count"></a> [status_check_failed_count](#input_status_check_failed_count)       | The number of failed status checks before the alarm is triggered | `number`                                                                                                               | `1`         |    no    |
| <a name="input_status_check_failed_enabled"></a> [status_check_failed_enabled](#input_status_check_failed_enabled) | Enable status check failed alarm                                 | `bool`                                                                                                                 | `true`      |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                      | A map of tags to add to all resources.                           | `map(string)`                                                                                                          | `{}`        |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
