output "instance_id" {
  description = "ID of the ec2-instance"
  value       = aws_instance.app_server[*].id
}
