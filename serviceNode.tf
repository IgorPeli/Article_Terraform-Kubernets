resource "kubernetes_service" "NodePort" {
  metadata {
    namespace = kubernetes_namespace.namespace.metadata[0].name
    name      = "service-nodeport"
  }
  spec {
    selector = {
      app = "frontend"
    }
    port {
      port        = 80
      target_port = 80
      node_port   = 30080

    }
    type = "NodePort"
  }

}