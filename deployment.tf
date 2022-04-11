resource "kubernetes_namespace" "breweries" {
  metadata {
    annotations = {
      name = "breweries"
    }

    labels = {
      mylabel = "breweries"
    }

    name = "breweries"
  }
  depends_on = [module.eks]
}
resource "kubernetes_deployment" "breweries-demo" {
  metadata {
    name = "breweries-demo"
    labels = {
      app = "breweries"
    }
    namespace = kubernetes_namespace.breweries.id
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "breweries"
      }
    }

    template {
      metadata {
        labels = {
          app = "breweries"
        }
      }

      spec {
        container {
          image = "514680112291.dkr.ecr.eu-central-1.amazonaws.com/breweries:latest"
          name  = "breweries"
          resources {
            limits = {
              cpu    = "500m"
              memory = "384Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }
          readiness_probe {
            http_get {
              path = "/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 60
            timeout_seconds       = 3
          }
          liveness_probe {
            http_get {
              path = "/actuator/health"
              port = 8080
            }
            initial_delay_seconds = 65
            timeout_seconds       = 3
          }
          port {
            container_port = 8080
          }
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.breweries]
}