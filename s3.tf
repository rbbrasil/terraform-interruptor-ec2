resource "aws_s3_bucket" "bucket" {
  bucket = var.nome_bucket
  acl    = "public-read"

  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "html" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "s3_html/index.html"
  acl    = "public-read"
}

