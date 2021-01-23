resource "kubernetes_namespace" "release-namespace" {
  metadata {
    name = var.namespace
  }
}