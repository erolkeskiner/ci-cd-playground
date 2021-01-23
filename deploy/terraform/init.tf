provider "kubernetes" {
  config_context_cluster = "minikube"
  config_path = var.kube-config-path
}
provider "helm" {
  kubernetes {
    config_context_cluster = "minikube"
    config_path = var.kube-config-path
  }
}