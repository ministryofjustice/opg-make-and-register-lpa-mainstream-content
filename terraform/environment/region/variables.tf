variable "mrlpa_content_container_sha_digest" {
  type        = string
  description = "The SHA256 digest of the container image to deploy"
}

variable "mrlpa_content_repository_url" {
  type        = string
  description = "The URL of the ECR repository containing the container image to deploy"
}
