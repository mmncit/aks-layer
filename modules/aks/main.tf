data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.resource_group_name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${var.resource_group_name}-nrg"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = true
    max_count           = 3
    min_count           = 1
    node_labels = {
      "nodepool-type" = "system"
      "envionrment"   = "dev"
      "nodepools"     = "linux"
    }
  }

  tags = {
    Environment = "dev"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = var.ssh_key
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
}


