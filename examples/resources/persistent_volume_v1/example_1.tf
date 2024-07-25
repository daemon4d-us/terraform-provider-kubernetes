resource "kubernetes_persistent_volume_v1" "example" {
  metadata {
    name = "terraform-example"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      vsphere_volume {
        volume_path = "/absolute/path"
      }
    }
  }
}
