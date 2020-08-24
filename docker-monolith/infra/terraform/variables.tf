variable cloud_id {
  description = "Cloud"
}

variable folder_id {
  description = "Folder"
}

variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable subnet_id {
  description = "Subnet"
}

variable service_account_key_file {
  description = "SA key file"
}

variable counts {
  description = "Count of instances"
  default     = 1
}

variable app_disk_image {
  description = "App Image"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Data Base Image"
  default     = "reddit-db-base"
}
