resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "monitoring"
    }

    labels = {
      mylabel = "monitoring"
    }

    name = "monitoring"
  }
  depends_on = [module.eks]
}

# resource "helm_release" "prometheus" {
#   chart      = "prometheus"
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   set {
#     name  = "alertmanager\\.persistentVolume\\.storageClass"
#     value = "gp2"
#   }
#   set {
#     name  = "server\\.persistentVolume\\.storageClass"
#     value = "gp2"
#   }
#   depends_on = [module.eks]
# }

resource "helm_release" "prometheus-stack" {
  chart      = "kube-prometheus-stack"
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  set {
    name  = "alertmanager\\.persistentVolume\\.storageClass"
    value = "gp2"
  }
  set {
    name  = "server\\.persistentVolume\\.storageClass"
    value = "gp2"
  }
  set {
    name  = "defaultRules.create"
    value = true
  }
  depends_on = [module.eks]
}
