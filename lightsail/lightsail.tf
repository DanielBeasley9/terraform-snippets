provider "aws" {
  region = "eu-west-2"
}

resource "aws_budgets_budget" "lightsail_budget" {
  name              = "budget-lightsail-monthly"
  budget_type       = "COST"
  limit_amount      = "15"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["danbeasley1998@gmail.com"]
    notification_type          = "FORECASTED"
  }
}

# Lightsail WordPress Instance
resource "aws_lightsail_instance" "wordpress" {
  name              = "wordpress-instance"
  availability_zone = "eu-west-2a"
  blueprint_id      = "wordpress"
  bundle_id         = "micro_1_0"

  tags = {
    Name = "WordPressInstance"
  }
}

# Static IP
resource "aws_lightsail_static_ip" "wordpress_ip" {
  name = "wordpress-static-ip"
}

# Attach Static IP to Instance
resource "aws_lightsail_static_ip_attachment" "wordpress_ip_attach" {
  static_ip_name  = aws_lightsail_static_ip.wordpress_ip.name
  instance_name   = aws_lightsail_instance.wordpress.name
}