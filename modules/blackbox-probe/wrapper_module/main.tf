# This wrapper module calls the generic 'probe' module with hardcoded defaults.
module "probe" {
  source = "../probe" # Call the generic probe module

  # --- Pass through the variables from this wrapper ---
  base_name = var.base_name
  targets   = var.targets
  module    = var.module

  # --- Hardcode the project's standard defaults ---
  namespace = "monitoring"

  prober_url = "prometheus-blackbox-exporter.monitoring.svc:9115"

  labels = {
    release = "prometheus-operator"
  }
}
