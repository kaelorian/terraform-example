resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    annotations = {
      name = "ingress-nginx"
    }

    labels = {
      mylabel = "ingress-nginx"
    }

    name = "ingress-nginx"
  }
  depends_on = [module.eks]
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = kubernetes_namespace.ingress-nginx.id
  depends_on = [kubernetes_namespace.ingress-nginx]

  set {
    name  = "service.targetPorts.https"
    value = "80"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"
    value = "arn:aws:acm:eu-central-1:514680112291:certificate/40dad729-351a-45f5-a47b-6f731d7e3f80"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"
    value = "https"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol"
    value = "http"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-connection-idle-timeout"
    value = "60"
    type  = "string"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    value = "true"
    type  = "string"
  }
  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }

}

resource "kubernetes_ingress" "nginx_ingress" {
  metadata {
    name = "nginx-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/limit-connections"      = "10"
      "kubernetes.io/ingress.class"                        = "nginx"
      "nginx.ingress.kubernetes.io/limit-rps"              = "5"
      "nginx.ingress.kubernetes.io/limit-burst-multiplier" = "2"
      "nginx.ingress.kubernetes.io/use-regex"              = "true"
    }
    namespace = kubernetes_namespace.breweries.id
  }
  spec {
    backend {
      service_name = "breweries-service"
      service_port = 8080
    }
    rule {
      host = "student-one.app-crafters.com"
      http {
        path {
          backend {
            service_name = "breweries-service"
            service_port = 8080
          }
          path = "/(api/breweries|actuator/health)"
        }
      }
    }
    /*tls {
      secret_name = "tls-secret"
    }*/
  }
  depends_on = [kubernetes_namespace.ingress-nginx]
}
resource "kubernetes_ingress" "nginx_ingress_2" {
  metadata {
    name = "nginx-ingress-2"
    annotations = {
      "nginx.ingress.kubernetes.io/limit-connections"      = "20"
      "kubernetes.io/ingress.class"                        = "nginx"
      "nginx.ingress.kubernetes.io/limit-rps"              = "10"
      "nginx.ingress.kubernetes.io/limit-burst-multiplier" = "4"
    }
    namespace = kubernetes_namespace.breweries.id
  }
  spec {
    backend {
      service_name = "breweries-service"
      service_port = 8080
    }
    rule {
      host = "student-one.app-crafters.com"
      http {
        path {
          backend {
            service_name = "breweries-service"
            service_port = 8080
          }
          path = "/"
        }
      }
    }
    /*tls {
      secret_name = "tls-secret"
    }*/
  }
  depends_on = [kubernetes_namespace.ingress-nginx]
}