variable "kube-config-path" {
  default = "~/.kube/config"
}
variable "namespace" {
  default = "example-namespace"
}
variable "helm-chart-path" {
  # this variable may be renamed if the chart is to be downloaded from an address.
  default = "../helm-chart/flask-app"
}
variable "helm-release-name" {
  default = "example-release"
}
variable "helm-values-override-path" {
  default = "../helm-chart/values-override.yaml"
}
variable "tag" {
  default = "0.1.0"
}
