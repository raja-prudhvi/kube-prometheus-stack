# create a helm chart for kube-prometheus-stack via terraform

locals {
    kube_prometheus_stack_namespace = "monitoring"
    kube_prometheus_stack_chart_name = "kube-prometheus-stack"
    kube_prometheus_stack_chart_version = "56.8.2"
    monitoring_chart_repository = "https://prometheus-community.github.io/helm-charts"

    services = {
    "grafana" = {
      host = "internal.${var.dns_name}"
      service = "${local.kube_prometheus_stack_chart_name}-grafana.${local.kube_prometheus_stack_namespace}.svc.cluster.local"
      pathPrefix = "/grafana"
      port = 3000
    },
    "prometheus" = {
      host = "internal.${var.dns_name}"
      service = "${local.kube_prometheus_stack_chart_name}-prometheus.${local.kube_prometheus_stack_namespace}.svc.cluster.local"
      pathPrefix = "/prometheus"
      port = 9090
    },
    "alertmanager" = {
      host = "internal.${var.dns_name}"
      service = "${local.kube_prometheus_stack_chart_name}-alertmanager.${local.kube_prometheus_stack_namespace}.svc.cluster.local"
      pathPrefix = "/alertmanager"
      port = 9093
    },
  }
}

# create a namespace for monitoring and enable istio injection

resource "kubernetes_namespace" "monitoring_namespace" {
    metadata {
        name = local.kube_prometheus_stack_namespace
        labels = {
            "istio-injection" = "enabled"
        }
    }
}

# install kube-prometheus-stack

resource "helm_release" "monitoring" {
    name       = local.kube_prometheus_stack_chart_name
    chart      = local.kube_prometheus_stack_chart_name
    repository = local.monitoring_chart_repository
    namespace  = kubernetes_namespace.monitoring_namespace.metadata[0].name
    version    = local.kube_prometheus_stack_chart_version

    values = [file("${path.module}/helm_values/kube-prometheus-stack.yaml")]

    depends_on = [kubernetes_namespace.monitoring_namespace]
}

# create a virtual service for each service in the kube-prometheus-stack
resource "kubernetes_manifest" "app_virtualservice" {
  for_each = local.services

  manifest = {
    apiVersion = "networking.istio.io/v1beta1"
    kind       = "VirtualService"
    metadata = {
      name      = each.key
      namespace = local.kube_prometheus_stack_namespace
    }
    spec = {
      hosts    = [each.value.host]
      gateways = ["${var.istio_gateway_namespace}/${var.applications_gateway}"]
      http = [
        {
          match = [{
            uri = {
              prefix = each.value.pathPrefix
            }
          }]
          route = [{
            destination = {
              host = each.value.service
              port = {
                number = each.value.port
              }
            }
          }]
        }
      ]
    }
  }
}

