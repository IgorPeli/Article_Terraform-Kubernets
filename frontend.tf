resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend-deployment"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {

        # 🔹 Volume com nginx.conf
        volume {
          name = "nginx-conf"
          config_map {
            name = kubernetes_config_map.frontend_nginx_conf.metadata[0].name
          }
        }

        # 🔹 Volume com index.html
        volume {
          name = "frontend-html"
          config_map {
            name = kubernetes_config_map.frontend_html.metadata[0].name
          }
        }

        container {
          name  = "nginx-front"
          image = "nginx:alpine"

          port {
            container_port = 80
          }

          # 🔹 Monta nginx.conf customizado
          volume_mount {
            name       = "nginx-conf"
            mount_path = "/etc/nginx/nginx.conf"
            sub_path   = "nginx.conf"
          }

          # 🔹 Monta index.html
          volume_mount {
            name       = "frontend-html"
            mount_path = "/usr/share/nginx/html/index.html"
            sub_path   = "index.html"
          }
        }
      }
    }
  }
}
