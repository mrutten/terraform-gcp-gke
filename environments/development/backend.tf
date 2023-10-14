terraform {
  backend "gcs" {
    bucket = "tfstate-binaryvision-nl"
    prefix = "environments/development/gke"
  }
}
