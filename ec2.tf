resource "aws_key_pair" "par_chaves" {
  public_key = file(var.caminho_par_chaves)
  key_name   = "par_chaves"
}


resource "aws_instance" "servidor_inutil" {
  ami                    = data.aws_ami.ubuntu.image_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.par_chaves.key_name
  vpc_security_group_ids = [aws_security_group.sg_servidor_inutil.id]
}
