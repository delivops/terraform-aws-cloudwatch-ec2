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



module "test-aurora-1-alarms" {
  source          = "delivops/alerts/groundcover"
  version         = "0.0.X"
  db_instance_id                   = "test-aurora-1"
  aws_sns_topic_arn                = aws_sns_topic.opsgenie_topic.arn
  high_connections_max_connections = 1365
  high_memory_max_allocations      = 16
  depends_on = [ aws_sns_topic.opsgenie_topic ]
}


```

## information

1. high cpu- with threshold:
   You enter the threshold for CPU, for example 80%. In case of alerts, the solution will be increasing the cpu of your instance.

2. high memory- with threshold:
   You enter the threshold for Memory, for example 80%. You are also enter the memory allocate for your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the memory of your instance.
3. high connections- with threshold:
   You enter the threshold for Connections, for example 80%. You are also enter the connections allocate for your instance-id, which you can find here: [Link text Here](https://sysadminxpert.com/aws-rds-max-connections-limit/#google_vignette)
   In case of alerts, the solution will be increasing the connections of your instance.
4. high storage- with threshold:
   You enter the threshold for storage, for example 80%.
   In case of alerts, the solution will be increasing the storage of your instance.
5. high write latency- with seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 2sc.
   In case of alerts, you should decrease the traffic to your instance.
6. high read latency- with seconds
   You enter the number of seconds that you can bear as latency, the recommendation is 0.02sc.
   In case of alerts, you should decrease the traffic to your instance or add a read replica.
7. disk queue depth too high- with number
   You enter the number of depths that you can bear in your instance, the recommendation is 64.
   In case of alerting, the solution is increasing the read/write capacity of your instance.
8. swap usage too high- with number
   You enter the number of memory allocate for swap that you can bear in your instance, the recommendation is 256000000 (256MB).
   In case of alerting, the solution is increasing the memory of your instance.

## License

MIT

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                   | Version   |
| ------------------------------------------------------ | --------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 4.67.0 |

## Providers

| Name                                             | Version   |
| ------------------------------------------------ | --------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 4.67.0 |

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

| Name                                                                                                               | Description                                                      | Type          | Default | Required |
| ------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------- | ------------- | ------- | :------: |
| <a name="input_aws_sns_topic_arn"></a> [aws_sns_topic_arn](#input_aws_sns_topic_arn)                               | The ARN of the SNS topic to send CloudWatch alarms to.           | `string`      | n/a     |   yes    |
| <a name="input_ec2_instance_id"></a> [ec2_instance_id](#input_ec2_instance_id)                                     | The instance ID of the EC2 instance that you want to monitor.    | `string`      | n/a     |   yes    |
| <a name="input_high_cpu_enabled"></a> [high_cpu_enabled](#input_high_cpu_enabled)                                  | Enable high CPU alarm                                            | `bool`        | `true`  |    no    |
| <a name="input_high_cpu_threshold"></a> [high_cpu_threshold](#input_high_cpu_threshold)                            | The threshold for high CPU usage                                 | `number`      | `90`    |    no    |
| <a name="input_high_disk_enabled"></a> [high_disk_enabled](#input_high_disk_enabled)                               | Enable high disk alarm                                           | `bool`        | `true`  |    no    |
| <a name="input_high_disk_threshold"></a> [high_disk_threshold](#input_high_disk_threshold)                         | The threshold for high disk usage                                | `number`      | `90`    |    no    |
| <a name="input_high_memory_enabled"></a> [high_memory_enabled](#input_high_memory_enabled)                         | Enable high memory alarm                                         | `bool`        | `true`  |    no    |
| <a name="input_high_memory_threshold"></a> [high_memory_threshold](#input_high_memory_threshold)                   | The threshold for high memory usage                              | `number`      | `90`    |    no    |
| <a name="input_status_check_failed_count"></a> [status_check_failed_count](#input_status_check_failed_count)       | The number of failed status checks before the alarm is triggered | `number`      | `1`     |    no    |
| <a name="input_status_check_failed_enabled"></a> [status_check_failed_enabled](#input_status_check_failed_enabled) | Enable status check failed alarm                                 | `bool`        | `true`  |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                      | A map of tags to add to all resources.                           | `map(string)` | `{}`    |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
