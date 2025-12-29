# ------------------------------------------------------------
# Workload VM Outputs
# ------------------------------------------------------------

output "workload_vm_private_ip" {
  value = module.workload_vm.vm_private_ip
}

output "workload_vm_identity_principal_id" {
  value = module.workload_vm.vm_identity_principal_id
}

