variable "base_name" {
  description = "The base name for the probe. This will be used for the Prometheus job_name and to derive the Kubernetes metadata.name (e.g., 'my-service-probe')."
  type        = string
}

variable "targets" {
  description = "A list of static URLs for the Blackbox Exporter to probe."
  type        = list(string)
}

variable "module" {
  description = "The Blackbox Exporter module to use."
  type        = string
  default     = "http_2xx"
}
