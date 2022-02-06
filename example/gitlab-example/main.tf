module "wm-gitlab-demo" {
  source = "git::https://github.com/jomcy-amzn/wm-serverlesslambda.git"
}

output "wm_get_url" {
  value = module.wm-gitlab-demo.wm_read_url
}
