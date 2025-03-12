resource "kubernetes_persistent_volume_claim" "grafana_pvc" {
  metadata {
    name      = "pvc"
    namespace = "monitoring"
    annotations = {
      "helm.sh/resource-policy" = "keep"
    }
    labels = {
      app = "grafana"
    }
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    storage_class_name = "standard"
  }

  lifecycle {
    prevent_destroy = true
  }
}
