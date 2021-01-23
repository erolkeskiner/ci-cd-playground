resource "helm_release" "local" {
  name = var.helm-release-name
  chart = var.helm-chart-path
  namespace = var.namespace
  values = [
    file(var.helm-values-override-path)
  ]
}