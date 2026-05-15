#----------------------------------------------------------------
# CLOUDFRONT DISTRIBUTION
# Creates a global CDN in front of the S3 static website
#----------------------------------------------------------------

resource "aws_cloudfront_distribution" "resume_cdn" {

  #----------------------------------------------------------------
  # ORIGIN CONFIGURATION
  # Defines where Cloudfront fetches website content from
  #----------------------------------------------------------------

  origin {

    # S3 static website endpoint used as Cloudfront origin
    domain_name = aws_s3_bucket_website_configuration.resume_website.website_endpoint

    # Unique identifier for this origin inside CloudFront
    origin_id = "resumeS3Origin"

    #------------------------------------------------------------------
    # CUSTOM ORIGIN CONFIG
    # Required because S3 website endpoints behave like normal 
    # HTTP web servers, not S3 REST APIs
    #------------------------------------------------------------------

    custom_origin_config {
      http_port  = 80
      https_port = 443

      # CloudFront communication with origin using HTTP only
      # (common for S3 website endpoints)
      origin_protocol_policy = "http-only"

      # Allowed SSL/TLS protocol versions
      origin_ssl_protocols = ["TLSv1.2"]

    }
  }

  #-------------------------------------------------------------------
  # DISTRIBUTION SETTINGS
  #------------------------------------------------------------------

  # Enables the CloudFront distribution
  enabled = true
  # Enables IPV6 support
  is_ipv6_enabled = true

  # Default file served when users visit root domain
  default_root_object = "index.html"

  #------------------------------------------------------------------
  # CACHE BEHAVIOR
  # controls how CloudFront handles requests
  #--------------------------------------------------------------------   
  default_cache_behavior {
    # HTTP methods CloudFront accepts from viewers
    allowed_methods = ["GET", "HEAD"]

    # Method CloudFront caches 
    cached_methods = ["GET", "HEAD"]

    # Connects cache behavior to defined origin
    target_origin_id = "resumeS3Origin"

    # Authomatically redirect HTTP requests to HTTPS
    viewer_protocol_policy = "redirect-to-https"
    #---------------------------------------------------------------
    # FORWARDED VALUES
    # Controls what CloudFront forwards to origin
    #---------------------------------------------------------------
    forwarded_values {

      # Query strings are not forwarded 
      query_string = false

      # Cookies are not forwarded to origin
      cookies {
        forward = "none"

      }

    }

  }

  #-------------------------------------------------------------
  #  GEO RESTRICTIONS
  # Controls regional access to content 
  #-------------------------------------------------------------

  restrictions {
    geo_restriction {
      restriction_type = "none"

    }

  }

  #------------------------------------------------------------
  # SSL/TLS CERTIFICATE CONFIGURATION
  #-----------------------------------------------------------
  viewer_certificate {

    # Uses default CloudFront SSL certificate
    # Suitable for cloudfront.net domains

    cloudfront_default_certificate = true

  }

}




