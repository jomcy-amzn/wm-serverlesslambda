module "wm-github-demo" {
  source = "git::https://github.com/jomcy-amzn/wm-serverlesslambda.git"
}

output "wm-get_url" {
  value = module.wm-github-demo.wm_read_url
}
