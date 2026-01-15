resource "kubernetes_config_map" "frontend_nginx_conf" {
  metadata {
    name      = "frontend-nginx-conf"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    "nginx.conf" = <<-EOT
      events {}

      http {
        server {
          listen 80;

          location / {
            root   /usr/share/nginx/html;
            index  index.html;
          }

          # proxy do frontend para o backend (Service ClusterIP)
          location /api/ {
            proxy_pass http://clusterip-service.${kubernetes_namespace.namespace.metadata[0].name}.svc.cluster.local/;
          }
        }
      }
    EOT
  }
}

resource "kubernetes_config_map" "frontend_html" {
  metadata {
    name      = "frontend-html"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    "index.html" = <<-EOT
      <!doctype html>
      <html>
        <head><meta charset="utf-8"><title>Frontend Demo</title></head>
        <body>
          <h1>Frontend (nginx)</h1>
          <p><a href="/api/">Abrir Backend (/api/)</a></p>
        </body>
      </html>
    EOT
  }
}
