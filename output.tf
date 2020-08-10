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
  value = "http://${aws_s3_bucket.bucket.website_endpoint}"
}

output "endpoint_api" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}${aws_api_gateway_resource.resource.path}"
}

output "api_key" {
  value = aws_api_gateway_api_key.api_key.value
}
