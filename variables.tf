variable "region" {
  default = "eu-central-1"
}
variable "cluster_name" {
  default = "kaelscluster"
}
/*variable "map_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  description = "Additional IAM roles to add to the aws-auth configmap."
  default = [
    {
      rolearn  = "arn:aws:iam::469257831638:role/aws-service-role/eks-nodegroup.amazonaws.com/AWSServiceRoleForAmazonEKSNodegroup"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }
  ]

}*/

variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  description = "Additional IAM users to add to the aws-auth configmap."
  default = [
    {
      userarn  = "arn:aws:iam::514680112291:user/student-one-ci"
      username = "admin"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::514680112291:root"
      username = "admin"
      groups   = ["system:masters"]
    }
  ]
}
