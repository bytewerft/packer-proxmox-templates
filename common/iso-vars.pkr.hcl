// ISO Variables //
variable "iso_download_pve" {
  description = "Download the ISO directly on the Proxmox node."
  type        = bool
  default     = true
}

variable "iso_storage_pool" {
  type    = string
  default = "local"
}

variable "apt_proxy_http" {
  description = <<EOT
  APT proxy URL for Ubuntu, format: 'http://[[user][:pass]@]host[:port]/'. Default 'null' skips setting proxy.
  EOT
  type        = string
  default     = ""
}

variable "apt_proxy_https" {
  description = <<EOT
  APT proxy URL for Ubuntu, format: 'https://[[user][:pass]@]host[:port]/'. Default 'null' skips setting proxy.
  EOT
  type        = string
  default     = ""
}

variable "rocky_install_url" {
  description = "Installation tree URL - single source, not a mirror list."
  type        = map(string)
  default = {
    "rocky9"  = "https://mirror.netzwerge.de/rocky-linux/9/BaseOS/x86_64/kickstart/"
    "rocky10" = "https://mirror.netzwerge.de/rocky-linux/10/BaseOS/x86_64/kickstart/"
  }
}

variable "rocky_mirror_appstream" {
  description = "Appstream mirror list, if set packages will be updated on install."
  type        = map(string)
  default = {
    "rocky9" = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=AppStream-9"
    "rocky10" = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=AppStream-10"
  }
}

variable "rocky_mirror_extras" {
  description = "Extras mirror list, if set packages will be updated on install."
  type        = map(string)
  default = {
    "rocky9"  = "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-9&arch=x86_64"
    "rocky10" = "https://mirrors.fedoraproject.org/mirrorlist?repo=epel-10&arch=x86_64"
  }
}

variable "rocky_mirror_baseos" {
  description = "Baseos mirror list, if set packages will be updated on install."
  type        = map(string)
  default = {
    "rocky9"  = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=BaseOS-9"
    "rocky10" = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=BaseOS-10"
  }
}

variable "iso_url" {
  type = map(string)
  default = {
    "rocky9"   = "https://mirror.netzwerge.de/rocky-linux/9.7/isos/x86_64/Rocky-9.7-x86_64-boot.iso"
    "rocky10"  = "https://mirror.netzwerge.de/rocky-linux/10.1/isos/x86_64/Rocky-10.1-x86_64-boot.iso"
    "debian11" = "https://get.debian.org/images/archive/11.11.0/amd64/iso-cd/debian-11.11.0-amd64-netinst.iso"
    "debian12" = "https://get.debian.org/images/archive/12.12.0/amd64/iso-cd/debian-12.12.0-amd64-netinst.iso"
    "debian13" = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.2.0-amd64-netinst.iso"
    "fedora42" = "https://mirror.netzwerge.de/fedora/linux/releases/42/Server/x86_64/iso/Fedora-Server-netinst-x86_64-42-1.1.iso"
    "fedora43" = "https://mirror.netzwerge.de/fedora/linux/releases/43/Server/x86_64/iso/Fedora-Server-netinst-x86_64-43-1.6.iso"
    "ubuntu22" = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
    "ubuntu24" = "https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso"
  }
}

variable "iso_checksum" {
  type = map(string)
  default = {
    "rocky9"   = "file:https://mirror.netzwerge.de/rocky-linux/9.7/isos/x86_64/Rocky-9.7-x86_64-boot.iso.CHECKSUM"
    "rocky10"  = "file:https://mirror.netzwerge.de/rocky-linux/10.1/isos/x86_64/Rocky-10.1-x86_64-boot.iso.CHECKSUM"
    "debian11" = "file:https://get.debian.org/images/archive/11.11.0/amd64/iso-cd/SHA256SUMS"
    "debian12" = "file:https://get.debian.org/images/archive/12.12.0/amd64/iso-cd/SHA256SUMS"
    "debian13" = "file:https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS"
    "fedora42" = "file:https://mirror.netzwerge.de/fedora/linux/releases/42/Server/x86_64/iso/Fedora-Server-42-1.1-x86_64-CHECKSUM"
    "fedora43" = "file:https://mirror.netzwerge.de/fedora/linux/releases/43/Server/x86_64/iso/Fedora-Server-43-1.6-x86_64-CHECKSUM"
    "ubuntu22" = "file:https://releases.ubuntu.com/22.04/SHA256SUMS"
    "ubuntu24" = "file:https://releases.ubuntu.com/24.04/SHA256SUMS"
  }
}

variable "unmount_iso" {
  type    = bool
  default = true
}

variable "os" {
  description = "OS Type, defaults to Linux 6.x-2.6 Kernel"
  type        = string
  default     = "l26"
}

variable "vm_id" {
  type = map(number)
  default = {
    "rocky9"   = 0
    "rocky10"  = 0
    "debian10" = 0
    "debian11" = 0
    "debian12" = 0
    "debian13" = 0
    "fedora42" = 0
    "fedora43" = 0
    "ubuntu22" = 0
    "ubuntu24" = 0
  }
}

// Boot Commands //
variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "boot_key_interval" {
  type = string
  default = "50ms"
}

variable "boot_cmd_debian" {
  description = "Boot command for Debian"
  type        = list(string)
  default = [
    "<tab>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "auto=true ",
    "priority=critical ",
    "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<wait><enter>"
  ]
}

variable "boot_cmd_fedora" {
  description = "Boot command for Fedora"
  type        = list(string)
  default = [
    "<up>",
    "e",
    "<down><down><down><left>",
    " hostname=fedora",
    " inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/anaconda-ks.cfg <wait><f10>"
  ]
}

variable "boot_cmd_ubuntu22" {
  description = "Boot command for Ubuntu 22 & 24"
  type        = list(string)
  default = [
    "c",
    "linux /casper/vmlinuz --- autoinstall 'ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot<enter>"
  ]
}

variable "boot_cmd_rocky9" {
  description = "Boot command for Rocky 9"
  type        = list(string)
  default = [
    "<up>",
    "<tab>",
    " inst.text",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/anaconda-ks.cfg",
    "<enter>"
  ]
}

variable "boot_cmd_rocky10" {
  description = "Boot command for Rocky 10"
  type        = list(string)
  default = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    " inst.text",
    " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/anaconda-ks.cfg",
    "<enter><f10>"
  ]
}
