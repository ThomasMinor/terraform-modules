# TODO

## Introduction

This module manages TODO.

## Usage

Instantiate the module by calling it from Terraform like this:

```hcl
module "aws-eks" {
  source = "dodevops/TODO"
  version = "<version>"
  
  (...)
}
```

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Development

Use [the terraform module tools](https://github.com/dodevops/terraform-module-tools) to check and generate the documentation by running

    docker run -v "$PWD":/terraform ghcr.io/dodevops/terraform-module-tools:latest
