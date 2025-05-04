resource "kubernetes_deployment" "todo_app" {
  metadata {
    name = "todo-deployment"
    labels = {
      app = "todo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "todo"
      }
    }

    template {
      metadata {
        labels = {
          app = "todo"
        }
      }

      spec {
        container {
          name  = "todo"
          image = "jvavm/getting-started:latest"
          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "todo_service" {
  metadata {
    name = "todo-service"
  }

  spec {
    selector = {
      app = "todo"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}