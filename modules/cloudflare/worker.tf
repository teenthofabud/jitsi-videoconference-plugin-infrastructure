
resource "cloudflare_worker" "proxy_worker" {
  account_id = local.account_id
  name = var.proxy_worker_name
  observability = {
    enabled = true
  }
}

resource "cloudflare_worker_version" "proxy_worker_version" {
  account_id = local.account_id
  worker_id = cloudflare_worker.proxy_worker.id
  compatibility_date = "2025-02-21" # Set this to today's date
  main_module = var.proxy_worker_module_name
  modules = [
    {
      name = var.proxy_worker_module_name
      content_type = "application/javascript+module"
      # Replacement (version creation) is triggered whenever this file changes
      content_file = var.proxy_worker_path
    }
  ]
  bindings = [
    {
      name = "S3_WEBSITE_ORIGIN"
      type = "plain_text"
      text = var.static_website_endpoint
    }
  ]

}

resource "cloudflare_workers_deployment" "proxy_worker_deployment" {
  account_id = local.account_id
  script_name = cloudflare_worker.proxy_worker.name
  strategy = "percentage"
  versions = [{
    percentage = 100
    version_id = cloudflare_worker_version.proxy_worker_version.id
  }]
}

resource "cloudflare_workers_route" "proxy_workers_route" {
  zone_id = local.zone_id
  pattern = var.incoming_request_pattern_for_proxy
  script  = cloudflare_worker.proxy_worker.name
}