resource "kubernetes_manifest" "probe" {
  manifest = {
    apiVersion = "monitoring.coreos.com/v1"
    kind       = "Probe"
    metadata = {
      name      = "${var.base_name}-probe"
      namespace = var.namespace
      labels    = var.labels
    }
    spec = {
      jobName  = var.base_name
      module   = var.module
      interval = var.interval
      prober = {
        url = var.prober_url
      }
      targets = {
        staticConfig = {
          static = var.targets
        }
      }
    }
  }
}
