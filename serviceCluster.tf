resource "kubernetes_service" "clusterIp" {
  metadata {
    name      = "clusterip-service"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  spec {
    selector = {
      app = "backend"
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }


}