output "probe_name" {
  description = "The name of the created Kubernetes Probe resource."
  value       = kubernetes_manifest.probe.object.metadata.name
}

output "probe_namespace" {
  description = "The namespace of the created Kubernetes Probe resource."
  value       = kubernetes_manifest.probe.object.metadata.namespace
}
