# 91_update_alb_test## Description

This module provides an elastic load balancer fully functional to be immediately added to your project

## Resources

By adding this module to your project, you will create the following resources:

  - An application Load Balancer

  - A Target Group

  - A LB listener for port 80

  - A LB listener for port 443


## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "alb" {
  source           = "./"
  name             = "my_alb"
  is_internal      = false
  alb_sg           = ["my_sg_id"]
  ssl_cert_arn     = "my_certificate_arn"
  subnets_id       = ["my_subnets"]
  vpc_id           = "vpc_id"
  logs_bucket      = "my_s3_bucket_logs"
}

```



## Inputs

| Name              | Description                                                                                |  Type   |                Default                | Required |
| ----------------- | ------------------------------------------------------------------------------------------ | :-----: | :-----------------------------------: | :------: |
| additional_certs  | List of ARNs of additional certificates to be attached to the load balancer                |  List   |            [] (empty list)            |    no    |
| alb_sg            | Security group IDs to assign to the LB                                                     | String  |                   -                   |   yes    |
| cross_zone_lb     | Cross-zone load balancing feature of the load balancer                                     | Boolean |                 true                  |    no    |
| delete_protection | If true, deletion of the load balancer will be disabled via the AWS API                    | Boolean |                 false                 |    no    |
| idle_timeout      | The time in seconds that the connection is allowed to be idle                              | Integer |                  60                   |    no    |
| is_internal       | If true, the LB will be internal                                                           | Boolean |                   -                   |    no    |
| name              | Load balancer name                                                                         | String  |                                       |   yes    |
| ssl_cert_arn      | The ARN of the certificate to attach to the listener                                       | String  |                   -                   |   yes    |
| ssl_policy        | The security policy that negotiates SSL connections between a client and the load balancer | String  | ELBSecurityPolicy-TLS-1-2-Ext-2018-06 |    no    |
| subnets_id        | A list of subnet IDs to attach to the LB.                                                  |  List   |                   -                   |   yes    |
| tags              | Tags that will be applied to the components related with this module                       |   map   |         { terraform = true }          |    no    |
| vpc_id            | The VPC ID in which the load balancer will be created                                      | String  |                   -                   |   yes    |

## Outputs

| Name                        | Description                                       |
| --------------------------- | ------------------------------------------------- |
| alb_arn                     | ARN of the LoadBalancer                           |
| alb_arn_suffix              | ARN Suffix of the LoadBalancer                    |
| alb_dns_name                | The DNS name of the load balancer                 |
| alb_hosted_zone_id          | The canonical hosted zone ID of the load balancer |
| alb_listener_80_arn         | The ARN of the listener 80                        |
| alb_listener_443_arn        | The ARN of the listener 443                       |
| alb_name                    | Name of the Load Balancer                         |
| alb_target_group_arn        | The target group ARN                              |
| alb_target_group_arn_suffix | The target group ARN suffix                       |