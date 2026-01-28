variable "base_name" {
  description = "The base name for the probe. This will be used for the Prometheus job_name and to derive the Kubernetes metadata.name (e.g., 'my-service-probe')."
  type        = string
}

variable "module" {
  description = "The Blackbox Exporter module to use (e.g., http_2xx, tcp_connect)."
  type        = string
  default     = "http_2xx"
}

variable "interval" {
  description = "The interval at which to run the probe."
  type        = string
  default     = "60s"
}

variable "prober_url" {
  description = "The full URL of the Blackbox Exporter's service."
  type        = string
}

variable "targets" {
  description = "A list of static URLs for the Blackbox Exporter to probe."
  type        = list(string)
}

variable "labels" {
  description = "A map of labels to apply to the Probe resource metadata for discovery by Prometheus Operator."
  type        = map(string)
  default     = {}
}
