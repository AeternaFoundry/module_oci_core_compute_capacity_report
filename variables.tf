variable "core_compute_capacity_reports" {
  description = <<EOT
Map of core_compute_capacity_reports, attributes below
Required:
    - availability_domain
    - compartment_id
    - shape_availabilities (block):
        - fault_domain (optional)
        - instance_shape (required)
        - instance_shape_config (optional, block):
            - baseline_ocpu_utilization (optional)
            - memory_in_gbs (optional)
            - nvmes (optional)
            - ocpus (optional)
Optional:
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    availability_domain = string
    compartment_id      = string
    shape_availabilities = list(object({
      fault_domain   = optional(string)
      instance_shape = string
      instance_shape_config = optional(object({
        baseline_ocpu_utilization = optional(string)
        memory_in_gbs             = optional(number)
        nvmes                     = optional(number)
        ocpus                     = optional(number)
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.core_compute_capacity_reports : (
        length(v.shape_availabilities) >= 1
      )
    ])
    error_message = "Each shape_availabilities list must contain at least 1 items"
  }
}

