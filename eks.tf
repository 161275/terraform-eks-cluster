module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"
  name               = var.cluster_name
  kubernetes_version = "1.33"
  endpoint_public_access = true
  vpc_id                   = aws_vpc.main.id
  subnet_ids               = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  control_plane_subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }
  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]
      min_size     = 2
      max_size     = 4
      desired_size = 2
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

output "node_security_group_id" {
  value = module.eks.node_security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "sg-tf-in" {
  security_group_id = module.eks.node_security_group_id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = "tcp"
  to_port           = 31005

}