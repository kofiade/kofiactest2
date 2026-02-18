# 1. HARDCODED SECRETS (Major Red Flag)
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAEXAMPLE123456789"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

# 2. S3 BUCKET OPEN TO THE PUBLIC
resource "aws_s3_bucket" "leaky_data" {
  bucket = "company-confidential-backups"
}

resource "aws_s3_bucket_public_access_block" "bad_idea" {
  bucket = aws_s3_bucket.leaky_data.id

  # Setting these to false allows public access
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 3. SECURITY GROUP OPEN TO THE WORLD (SSH/RDP)
resource "aws_security_group" "wide_open" {
  name        = "allow_all"
  description = "Open to the world"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"        # All protocols
    cidr_blocks = ["0.0.0.0/0"] # The entire internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. UNENCRYPTED DATABASE WITH PUBLIC ACCESS
resource "aws_db_instance" "insecure_db" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "Password123!" # Plaintext weak password
  publicly_accessible    = true           # Accessible over the internet
  storage_encrypted      = false          # No encryption at rest
  skip_final_snapshot    = true
}
