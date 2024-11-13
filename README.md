# terraform-aws-cloudwatch-ec2

# terraform-aws-rds-cloudwatch

This Terraform module provisions alarms using aws cloudwatch for monitoring and notification RDS. The module allows you to create alerts based on various performance metrics of your RDS, helping you to proactively manage and respond to potential issues in your RDS.

## Installation

To use this module, you need to have Terraform installed. You can find installation instructions on the Terraform website.

## Usage

The module will create cloudwatch alarms for your RDS. You can use this module multiple times to create alarms with different configurations for various instances or metrics.

```python


################################################################################
# Cloudwatch Alarms for RDS
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
