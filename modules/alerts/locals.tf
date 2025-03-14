locals {
  host_environments = {
    dev  = "dev.geneticscores.org"
    test = "test.geneticscores.org"
    prod = "calculate.geneticscores.org"
  }
  host = local.host_environments[var.environment]
}