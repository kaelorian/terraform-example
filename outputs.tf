output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "kubectl_config" {
  value = module.eks.kubeconfig
}

output "region" {
  value = var.region
}

output "ng-role-arn" {
  value = aws_iam_role.ng-role.arn
}