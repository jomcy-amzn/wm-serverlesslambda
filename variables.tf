variable "region" {
  description = "Region for deploying infrastucture"
  default     = "us-west-2"
}














//Old  varaibles
/*

variable "name" {
  description = "Name given for infrastructure"
}
variable "vpc_id" {
  description = "VPC ID for the infrastucture deployment"
}

variable "web_subnet2_id" {
  description = "Private Subnet to host web teir"
}

variable "web_subnet1_id" {
  description = "Private Subnet to host web teir"
}

variable "application_subnet1_id" {
  description = "Private Subnet to host application teir"
}

variable "application_subnet2_id" {
  description = "Private Subnet to host application teir"
}

variable "db_subnet2_id" {
  description = "Private Subnet to host database teir"
}

variable "db_subnet1_id" {
  description = "Private Subnet to host database teir"
}

variable "web_elb_health_check_interval" {
  description = "Duration between health checks"
  default     = 20
}

variable "web_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default     = 2
}

variable "web_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default     = 2
}

variable "web_elb_health_check_timeout" {
  description = "Interval between checks"
  default     = 5
}

variable "web_port" {
  description = "The port on which the web servers listen for connections"
  default     = 80
}

variable "web_instance_type" {
  description = "The EC2 instance type for the web servers"
  default     = "t2.micro"
}

variable "web_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default     = 2
}

variable "web_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default     = 3
}


variable "app_elb_health_check_interval" {
  description = "Duration between health checks"
  default     = 20
}

variable "app_elb_healthy_threshold" {
  description = "Number of checks before an instance is declared healthy"
  default     = 2
}

variable "app_elb_unhealthy_threshold" {
  description = "Number of checks before an instance is declared unhealthy"
  default     = 2
}

variable "app_elb_health_check_timeout" {
  description = "Interval between checks"
  default     = 5
}

variable "app_port" {
  description = "The port on which the application listens for connections"
  default     = 8080
}

variable "app_instance_type" {
  description = "The EC2 instance type for the application servers"
  default     = "t2.micro"
}

variable "app_autoscale_min_size" {
  description = "The fewest amount of EC2 instances to start"
  default     = 2
}

variable "app_autoscale_max_size" {
  description = "The largest amount of EC2 instances to start"
  default     = 3
}

variable "public_key" {
  description = "Public key that should be used to launch both web servers and app servers!"
}

variable "db_identifier" {
  description = "The name of the RDS instance"
  default     = ""
}

variable "db_allocated_storage" {
  description = "The allocated storage in GB"
  default     = 5
}

variable "db_name" {
  description = "The DB name to create"
  default     = ""
}

variable "db_username" {
  description = "Username for the master DB user"
  default     = ""
}

variable "db_password" {
  description = "Password for the master DB user"
  default     = ""
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
  default     = 5432
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in"
  default     = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled"
  default     = "03:00-06:00"
}

variable "db_backup_retention_period" {
  description = "The days to retain backups for"
  default     = 0
}

*/
