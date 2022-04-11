resource "kubernetes_namespace" "metrics-server" {
  metadata {
    annotations = {
      name = "metrics-server"
    }

    labels = {
      mylabel = "metrics-server"
    }

    name = "metrics-server"
  }
  depends_on = [module.eks]
}
resource "helm_release" "metrics-server" {
  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  namespace  = kubernetes_namespace.metrics-server.id
  set {
    name  = "apiService.create"
    value = "true"
  }
  depends_on = [kubernetes_namespace.metrics-server]
}