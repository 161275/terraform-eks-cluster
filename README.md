Infrastructure
1. Create a remote backend on s3 
   -> ensuring state locking and security of sensitive informate in state file.
2. AWS provider for EKS creation 
   -> configured AWS cli with secret access key on the server from where we run terraform init plan and apply.
3. VPC with 3 public subnet along with security groups, internet gateway, route table and their association with subnets.
4. used EKS module by passing relevant information of VPC and required worker nodes.

Instructions to Run EKS Infra with terraform.
Pre-requisites : terraform should be installed and aws cli be configured.
                 -> ensure the user configured on aws cli has required permissions for EKS, VPC or admin permission
1. create s3 bucket to store statefile.
   -> go to backend dir and run terraform init terrafom plan and terraform apply.
2. create VPC and EKS.
   -> go to root dir of project and run terraform init terrafom plan and terraform apply.
3. to check install kubectl on a machine
   -> update kubeconfig aws *eks update-kubeconfig --region us-east-1 --name tf-eks-cluster*
   -> run kubectl get nodes
