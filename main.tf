
provider "helm" {
  kubernetes {
    config_path = "/Users/rubinaabajyan/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "/Users/rubinaabajyan/.kube/config"
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}

resource "helm_release" "prometheus" {
  name      = "prometheus"
  namespace = "test"


  #repository = "https://charts.bitnami.com/bitnami"
  chart = "./charts/prometheus"

  set {
    name  = "service.type"
    value = "NodePort"
  }

  set {
    name  = "kubeStateMetrics.enabled"
    value = "false"
  }
}

resource "helm_release" "grafana" {
  name      = "grafana"
  namespace = "test"


  #repository = "https://charts.bitnami.com/bitnami"
  chart = "./grafana"

  set {
    name  = "service.type"
    value = "NodePort"
  }
}
