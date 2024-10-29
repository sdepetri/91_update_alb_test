variable "idle_timeout" {
  default     = 60
  description = "connection idle time out, default=60"
  type        = number
}

variable "name" {
  description = "Load balancer name"
  type        = string
}

variable "is_internal" {
  description = "set true if the load balancer is private. this seting will not expose the elb to internet. default=false"
  default     = false
  type        = bool
}
variable "alb_sg" {
  description = "Security group assinged to the LB"
  type        = string
}

variable "subnets_id" {
  description = "List of subnets where the LB will place it's terminations"
  type        = list(any)
}

variable "delete_protection" {
  default     = false
  description = "Protect this resource for accidental deletion. values: true or false [default: false]"
  type        = bool
}

variable "cross_zone_lb" {
  default     = true
  description = "Allow cross zone load balancing, this setting allows to LB vpc terminations to reach targets in a different az that the assigned. [default=true]"
  type        = bool
}

variable "ssl_policy" {
  description = "AWS managed SSL Security Policy, needs to be one of the supported values expresend on the ELB docuemntation https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html. default=ELBSecurityPolicy-2016-08"
  default     = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  type        = string
}

variable "vpc_id" {
  description = "VPC id where the ALB will be placed"
  type        = string
}

variable "ssl_cert_arn" {
  description = "ARN of the SSL certificate that will be applied to the https listener"
  type        = string
}

variable "additional_certs" {
  description = "List of additional certificates that can be attached to the https listener, this uses SNI. default=[]"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Tags that will be applied to the components related with this module default: { terraform = true }"
  default = {
    terraform = true
  }
  type = map(any)
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
  type        = bool
  default     = false
}
