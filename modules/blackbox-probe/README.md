Ï# Terraform Blackbox Probe Module for Kubernetes

This repository contains a reusable Terraform module to create `Probe` custom resources for use with the [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) and the [Blackbox Exporter](https://github.com/prometheus/blackbox_exporter).

The `Probe` CRD allows you to easily define Blackbox targets for Prometheus to scrape, which is useful for monitoring endpoints from outside your application pods (e.g., checking public URLs, internal service endpoints, etc.).

## Prerequisites

Before using this module, you must have the following in your Kubernetes cluster:

1.  **Prometheus Operator**: A running instance of the Prometheus Operator.
2.  **`Probe` CRD**: The `Probe` Custom Resource Definition must be installed. This CRD is often included with the `kube-prometheus-stack` Helm chart or can be installed separately.
3.  **Blackbox Exporter**: A running instance of the Blackbox Exporter accessible from within the cluster.
4.  **Terraform**: Terraform installed with a configured `kubernetes` provider.

## Usage

The module can be used to define a probe for any service. The example below shows how to create a probe for a hypothetical service named `service-to-monitor`.

```terraform
# main.tf

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  # Your Kubernetes cluster configuration
  # config_path = "~/.kube/config"
}

# --- Create a probe for a generic service ---
module "service_to_monitor_probe" {
  source = "./modules/probe"

  name     = "service-to-monitor-healthz-probe"
  job_name = "service-to-monitor-healthz"
  
  # This label is required by your Prometheus Operator to discover Probes.
  # Adjust if your setup uses a different label selector.
  labels = {
    release = "prometheus-operator" 
  }

  # The internal Kubernetes service URL of your Blackbox Exporter.
  prober_url = "prometheus-blackbox-exporter.monitoring.svc:9115"

  # The endpoint(s) to probe.
  targets = [
    "http://service-to-monitor.svc.cluster.local/healthz"
  ]
}
```

## Module Inputs

| Name         | Description                                                                          | Type           | Default    | Required |
|--------------|--------------------------------------------------------------------------------------|----------------|------------|:--------:|
| `base_name`  | The base name for the probe. Used for `jobName` and to derive `metadata.name`.     | `string`       | -          |   yes    |
| `namespace`  | The Kubernetes namespace where the Probe resource will be created.                   | `string`       | `monitoring` |    no    |
| `module`     | The Blackbox Exporter module to use (e.g., `http_2xx`, `tcp_connect`).               | `string`       | `http_2xx` |    no    |
| `interval`   | The interval at which to run the probe.                                              | `string`       | `60s`      |    no    |
| `prober_url` | The full URL of the Blackbox Exporter's service.                                     | `string`       | -          |   yes    |
| `targets`    | A list of static URLs for the Blackbox Exporter to probe.                             | `list(string)` | -          |   yes    |
| `labels`     | A map of labels to apply to the Probe resource for discovery by Prometheus Operator. | `map(string)`  | `{}`       |    no    |

## Module Outputs

| Name              | Description                                        |
|-------------------|----------------------------------------------------|
| `probe_name`      | The name of the created Kubernetes Probe resource. |
| `probe_namespace` | The namespace of the created Kubernetes Probe resource. |

## How to Apply

1.  Initialize Terraform in the root directory:
    ```sh
    terraform init
    ```
2.  Review the plan:
    ```sh
    terraform plan
    ```
3.  Apply the configuration:
    ```sh
    terraform apply
    ```

---

## Advanced Usage: Wrapper Module

For larger projects, it's good practice to create an opinionated "wrapper" module that sets project-specific defaults. This simplifies the configuration and ensures consistency.

This repository includes an example wrapper module in `modules/my_project_probe`. It uses the generic `probe` module but hardcodes the `prober_url`, `namespace`, and `labels`, exposing only the variables that need to change for each probe.

### Example using the Wrapper Module

Using the wrapper simplifies your root `main.tf` significantly:

```terraform
# --- Use the simplified wrapper module ---
module "service_one_probe" {
  source = "./modules/my_project_probe" # Use the wrapper module

  base_name = "service-one-healthz"
  
  targets = [
    "http://service-one.default.svc.cluster.local/healthz"
  ]
}

module "service_two_probe" {
  source = "./modules/my_project_probe" # Reuse the same wrapper

  base_name = "service-two"
  
  targets = [
    "https://service-two.example.com"
  ]
}
```
