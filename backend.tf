resource "kubernetes_deployment" "backend" {
  metadata {
    name      = "backend-deployment"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {
      app = "backend"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "backend"
        }
      }
      spec {
        container {
          image = "nginxdemos/hello"
          name  = "nginx-front"
          port {
            container_port = 80
          }
        }
      }
    }

  }

}