# resource "kubernetes_manifest" "test-kubernetes-pod-crashlooping" {
#   manifest = {
#     "apiVersion": "monitoring.coreos.com/v1",
#     "kind": "PrometheusRule",
#     "metadata": {
#         "annotations": {
#         "meta.helm.sh/release-name": "kube-prometheus-stack",
#         "meta.helm.sh/release-namespace": "monitoring"
#         },
#         "labels": {
#         "app": "kube-prometheus-stack",
#         "app.kubernetes.io/instance": "kube-prometheus-stack",
#         "app.kubernetes.io/managed-by": "Helm",
#         "app.kubernetes.io/part-of": "kube-prometheus-stack",
#         "heritage": "Helm",
#         "release": "kube-prometheus-stack"
#         },
#         "name": "kubernetes-pod-crash-looping-50",
#         "namespace": "monitoring"
#     },
#     "spec": {
#         "groups": [
#         {
#             "name": "backend",
#             "rules": [
#             {
#                 "alert": "KubernetesPodCrashLooping50",
#                 "expr": "increase(kube_pod_container_status_restarts_total[5m]) > 0",
#                 "for": "2m",
#                 "labels": {
#                 "severity": "critical"
#                 },
#                 "annotations": {
#                 "summary": "Kubernetes pod crash looping (instance {{ $labels.instance }}) AppCTest",
#                 "description": "Pod {{ $labels.pod }} is crash looping AppCTest\n  VALUE = {{ $value }}\n  LABELS = {{ $labels }}"
#                 }
#             }
#             ]
#         }
#         ]
#     }
# }
#   timeouts {
#     create = "60s"
#     delete = "20s"
#   }
# }