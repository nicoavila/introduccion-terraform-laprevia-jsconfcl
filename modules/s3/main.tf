resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name
    force_destroy = true
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
    bucket = var.bucket_name
    policy = jsonencode({
        "Version": "2012-10-17",    
        "Statement": [        
            {            
                "Sid": "PublicReadGetObject",            
                "Effect": "Allow",            
                "Principal": "*",            
                "Action": [                
                    "s3:GetObject"            
                ],            
                "Resource": [
                    "arn:aws:s3:::${var.bucket_name}/*"            
                ]        
            }    
        ]
    })

    depends_on = [
      aws_s3_bucket.website_bucket
    ]
}

resource "aws_s3_bucket_website_configuration" "website_bucket_configuration" {
    bucket = aws_s3_bucket.website_bucket.bucket
    index_document {
      suffix = "index.html"
    }
    error_document {
      key = "index.html"
    }

    depends_on = [
      aws_s3_bucket.website_bucket
    ]
}

resource "aws_s3_object" "website" {
  bucket = var.bucket_name
  key = "index.html"
  acl = "public-read"
  content_type = "text/html"
  source = "content/index.html"
  source_hash  = filemd5("content/index.html")
}