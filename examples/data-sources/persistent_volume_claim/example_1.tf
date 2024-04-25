# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "kubernetes_persistent_volume_claim" "example" {
  metadata {
    name = "terraform-example"
  }
}
