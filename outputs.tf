output "replicated console password" {
  value = "${random_pet.replicated-pwd.id}"
}

output "pes_fqdn" {
  value = "${module.pes.pes_fqdn}"
}