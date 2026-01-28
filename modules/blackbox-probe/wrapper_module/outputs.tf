output "probe_name" {
  description = "The name of the created Kubernetes Probe resource."
  value       = module.probe.probe_name
}

output "probe_namespace" {
  description = "The namespace of the created Kubernetes Probe resource."
  value       = module.probe.probe_namespace
}
