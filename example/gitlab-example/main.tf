module "wm-gitlab-demo" {
  source = "git::https://github.com/jomcy-amzn/wm-serverlesslambda.git"
}

output "wm-get_url" {
  value = module.wm-gitlab-demo.wm-read_url
}
