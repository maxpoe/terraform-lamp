# Create the security group for web server
resource "aws_security_group" "sg_webserver" {
  name        = "sg_webserver"
  description = "Security Group for Webserver of LAMP Stack"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "sg_webserver"
    Owner = "${var.owner}"
  }
}

# Create an EC2 instance
resource "aws_instance" "webserver-lamp" {
  # AMI ID for AMZ LNX 2
  ami                    = var.ami
  key_name               = var.key_name
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.sg_webserver.id}"]
  subnet_id              = var.subnet_id

  tags = {
    Name  = "WebserverLAMP"
    Owner = "${var.owner}"
  }
}