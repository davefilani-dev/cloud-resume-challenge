
#=============================================
# S3 BUCKET CONFIGURATION
# Creates the main S3 bucket used for hosting
# the static frontend website
#============================================



resource "aws_s3_bucket" "resume_bucket" {

  bucket = var.bucket_name


  tags = {

    Name = "Cloud Resume Bucket"

    Environment = "Production"

  }

}

#===============================================
# STATIC WEBSITE HOSTING CONFIGURATION
# Enables S3 static website hosting and
# defines the index and error documents
#================================================

resource "aws_s3_bucket_website_configuration" "resume_website" {
  bucket = aws_s3_bucket.resume_bucket.id


  index_document {

    suffix = "index.html"

  }


  error_document {

    key = "error.html"

  }

}

#===============================================
# PUBLIC ACCESS CONFIGURATION
# Allows the bucket policy to expose the
# website publicly for browser access
#===============================================

resource "aws_s3_bucket_public_access_block" "resume_public_access" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls = false

  block_public_policy = false

  ignore_public_acls = false

  restrict_public_buckets = false

}

#====================================================
# S3 BUCKET POLICY
# Grants public read access to the website files
# such as index.html and script.js
#====================================================

resource "aws_s3_bucket_policy" "resume_bucket_policy" {
  bucket = aws_s3_bucket.resume_bucket.id

  depends_on = [
    aws_s3_bucket_public_access_block.resume_public_access
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {

        Sid    = "PublicReadGetObject"
        Effect = "Allow"


        Principal = "*"

        Action = [
          "s3:GetObject"

        ]


        Resource = [
          "${aws_s3_bucket.resume_bucket.arn}/*"

        ]

      }
    ]
  })

}
