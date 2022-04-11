# resource "kubernetes_manifest" "prometheusrule_monitoring_kube_prometheus_stack_alertmanager_rules" {
#   manifest = {
#     "apiVersion" = "monitoring.coreos.com/v1"
#     "kind" = "PrometheusRule"
#     "metadata" = {
#       "annotations" = {
#         "meta.helm.sh/release-name" = "kube-prometheus-stack"
#         "meta.helm.sh/release-namespace" = "monitoring"
#       }
#       "generation" = 1
#       "labels" = {
#         "app" = "kube-prometheus-stack"
#         "app.kubernetes.io/instance" = "kube-prometheus-stack"
#         "app.kubernetes.io/managed-by" = "Helm"
#         "app.kubernetes.io/part-of" = "kube-prometheus-stack"
#         "app.kubernetes.io/version" = "20.0.1"
#         "chart" = "kube-prometheus-stack-20.0.1"
#         "heritage" = "Helm"
#         "release" = "kube-prometheus-stack"
#       }
#       "name" = "kubernetes-pod-crash-looping.rules"
#       "namespace" = "monitoring"
#     }
#     "spec" = {
#       "groups" = [
#         {
#           "name" = "backend"
#           "rules" = [
#             {
#               "alert" = "KubernetesPodCrashLooping"
#               "annotations" = {
#                 "description" = "Pod {{ $labels.pod }} is crash looping"
#                 "runbook_url" = "https://github.com/kubernetes-monitoring/kubernetes-mixin/tree/master/runbook.md#alert-name-alertmanagerfailedreload"
#                 "summary" = "Kubernetes pod crash looping (instance {{ $labels.instance }})"
#               }
#               "expr" = "increase(kube_pod_container_status_restarts_total[5m]) > 0"
#               "for" = "2m"
#               "labels" = {
#                 "severity" = "critical"
#               }
#             },
#           ]
#         },
#       ]
#     }
#   }
# }
