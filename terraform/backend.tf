terraform {
  backend "gcs" {
    bucket = "my-sql-db-backup-bucket"  # your bucket name
    prefix = "terraform/state"
  }
}