resource "kubernetes_horizontal_pod_autoscaler" "breweries-hpa" {
  metadata {
    name      = "breweries-hpa"
    namespace = kubernetes_namespace.breweries.id
  }
  spec {
    min_replicas                      = 1
    max_replicas                      = 3
    target_cpu_utilization_percentage = 50
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "deployment"
      name        = "breweries-demo"
    }
  }
  depends_on = [helm_release.metrics-server]
}