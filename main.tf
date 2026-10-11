resource "oci_core_compute_capacity_report" "core_compute_capacity_reports" {
  for_each = var.core_compute_capacity_reports

  availability_domain = each.value.availability_domain
  compartment_id      = each.value.compartment_id

  dynamic "shape_availabilities" {
    for_each = each.value.shape_availabilities
    content {
      fault_domain   = shape_availabilities.value.fault_domain
      instance_shape = shape_availabilities.value.instance_shape
      dynamic "instance_shape_config" {
        for_each = shape_availabilities.value.instance_shape_config != null ? [shape_availabilities.value.instance_shape_config] : []
        content {
          baseline_ocpu_utilization = instance_shape_config.value.baseline_ocpu_utilization
          memory_in_gbs             = instance_shape_config.value.memory_in_gbs
          nvmes                     = instance_shape_config.value.nvmes
          ocpus                     = instance_shape_config.value.ocpus
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

