resource "google_storage_bucket" "sql_backup_bucket" {
  name          = "my-sql-db-backup-bucket"  # Change this to a unique bucket name
  location      = "US"                       # Change to your preferred region
  force_destroy = false

  lifecycle_rule {
    condition {
      age = 30  # optionally delete backups after 30 days
    }
    action {
      type = "Delete"
    }
  }
}
