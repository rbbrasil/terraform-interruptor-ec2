resource "aws_s3_bucket" "bucket" {
  bucket = "interruptor-inutil"
  acl    = "public"
}
