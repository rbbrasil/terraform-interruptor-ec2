resource "aws_security_group" "sg_servidor_inutil" {
  name = "sg_servidor_inutil"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// TODO - iam role para acesso do S3 a API GW
