output "ip_servidor_inutil" {
  value = aws_instance.servidor_inutil.public_ip
}

output "hostname_servidor_inutil" {
  value = aws_instance.servidor_inutil.public_dns
}
