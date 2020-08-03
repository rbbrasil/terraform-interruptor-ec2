resource "aws_s3_bucket" "bucket" {
  bucket = var.nome_bucket
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_object" "html" {
  bucket       = aws_s3_bucket.bucket.id
  key          = "index.html"
  source       = "s3_html/index.html"
  acl          = "public-read"
  content_type = "text/html"
  //  encoding     = "utf8"
}

