module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  cluster_name                    = var.cluster_name
  cluster_version                 = "1.20"
  version = "12.2.0"
  subnets                         = setunion(module.vpc.private_subnets, module.vpc.public_subnets)
  cluster_create_timeout          = "1h"
  cluster_endpoint_private_access = true
  vpc_id                          = module.vpc.vpc_id
  manage_cluster_iam_resources    = false
  cluster_iam_role_name           = aws_iam_role.eks-role.name

  tags = {
    "Name" = var.cluster_name
  }

  node_groups = [
    {
      name             = "ng1"
      iam_role_arn     = aws_iam_role.ng-role.arn
      instance_types   = ["t2.medium"]
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
      subnets          = module.vpc.private_subnets
    }
  ]
  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  #map_roles                            = var.map_roles
  map_users  = var.map_users
  depends_on = [module.vpc]

}