output "website_url" {
  value = aws_s3_bucket_website_configuration.resume_website.website_endpoint

}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.resume_cdn.domain_name

}
