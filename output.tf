output "ip_servidor_inutil" {
  value = aws_instance.servidor_inutil.public_ip
}

output "hostname_servidor_inutil" {
  value = aws_instance.servidor_inutil.public_dns
}

output "id_servidor_inutil" {
  value = aws_instance.servidor_inutil.id
}

output "endpoint_s3" {
  value = aws_s3_bucket.bucket.website_endpoint
}
