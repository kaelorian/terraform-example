resource "kubernetes_service" "service" {
  metadata {
    name      = "breweries-service"
    namespace = kubernetes_namespace.breweries.id
  }
  spec {
    selector = {
      app = "breweries"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
  depends_on = [kubernetes_deployment.breweries-demo]
}