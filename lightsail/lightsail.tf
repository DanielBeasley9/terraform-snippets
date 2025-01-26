provider "aws" {
  region = "eu-west-2"
}

# Lightsail WordPress Instance
resource "aws_lightsail_instance" "wordpress" {
  name              = "wordpress-instance"
  availability_zone = "eu-west-2"
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