# 📈 Kube-Prometheus-Stack Setup 📈

Welcome to the Kube-Prometheus-Stack setup repository! This Terraform module installs the kube-prometheus-stack Helm chart into a Kubernetes cluster, providing a comprehensive monitoring solution for Kubernetes environments.

## 🚀 Features of Kube-Prometheus-Stack

- **Comprehensive Monitoring Solution**: Kube-Prometheus-Stack includes Prometheus for metrics collection, Grafana for visualization, and Alertmanager for alerting, providing a complete monitoring solution for Kubernetes clusters.
- **Easy Installation with Helm**: Leveraging Helm, this module simplifies the installation process of the kube-prometheus-stack, allowing for quick deployment and configuration.
- **Automatic Service Discovery**: Prometheus automatically discovers Kubernetes services and ingresses, ensuring that all relevant metrics are collected and monitored.
- **Flexible Alerting Configuration**: Alertmanager enables flexible alerting rules configuration, allowing users to define custom alerting rules based on specific metrics and thresholds.
- **Scalable and Extensible**: The modular architecture of the kube-prometheus-stack makes it highly scalable and extensible, allowing for easy integration with additional monitoring components and custom metrics.
- **Integration with Istio**: Integration with Istio enables seamless monitoring of Istio components and service mesh traffic, providing insights into network traffic and performance.

## 📁 Project Structure

```
.
├── README.md
├── helm_values
│ └── kube-prometheus-stack.yaml
├── main.tf
└── variables.tf

```


## 🚀 Getting Started

1. **Install Terraform**: Make sure you have Terraform installed locally.
2. **Customize Variables**: Modify the variables in `variables.tf` as per your Kubernetes environment and requirements.
3. **Run Terraform**: Execute `terraform init` to initialize Terraform, then `terraform apply` to apply the changes and install the kube-prometheus-stack.

## 📈 Pod Status in the Monitoring Namespace


```

kubectl get pods -n monitoring
NAME                                                        READY   STATUS    RESTARTS      AGE
alertmanager-kube-prometheus-stack-alertmanager-0           3/3     Running   0             27d
kube-prometheus-stack-grafana-75f94df6bb-m7g6z              4/4     Running   0             27d
kube-prometheus-stack-kube-state-metrics-5556bcc856-s6fv6   2/2     Running   2 (27d ago)   27d
kube-prometheus-stack-operator-5fbfff5664-st7s7             2/2     Running   2 (27d ago)   27d
kube-prometheus-stack-prometheus-node-exporter-h8sfw        1/1     Running   0             27d
kube-prometheus-stack-prometheus-node-exporter-lp52k        1/1     Running   0             27d
prometheus-kube-prometheus-stack-prometheus-0               3/3     Running   0             27d

```


🔍 Checking Pod Status Locally
You can check the pod status locally by forwarding ports for each service:

Grafana : Access Grafana at http://localhost:3000 in your browser.

```
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80

```

Prometheus : Access Prometheus at http://localhost:9090 in your browser.

```
kubectl port-forward svc/prometheus-kube-prometheus-stack-prometheus -n monitoring 9090:9090

```

Alertmanager : Access Alertmanager at http://localhost:9093 in your browser.

```
kubectl port-forward svc/alertmanager-kube-prometheus-stack-alertmanager -n monitoring 9093:9093

```

