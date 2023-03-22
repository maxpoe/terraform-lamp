output "url" {
  value = "http://${aws_instance.webserver-lamp.public_ip}"
}

output "public_ip" {
  value = aws_instance.webserver-lamp.public_ip
}

output "private_ip" {
  value = aws_instance.webserver-lamp.private_ip
}

output "sg_webserver" {
  value = aws_security_group.sg_webserver.id
}