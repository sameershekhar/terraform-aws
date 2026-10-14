output "aws_instance_public_ip" {
  value = aws_instance.myserver-1.public_ip
}