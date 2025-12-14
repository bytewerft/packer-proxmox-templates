build {
  source "proxmox-iso.image" {
    name              = "rocky9"
    boot_command      = var.boot_cmd_rocky9
    boot_key_interval = var.boot_key_interval
    boot_wait         = var.boot_wait
    http_content = { "/anaconda-ks.cfg" = templatefile("configs/anaconda-ks.cfg",
      {
        rocky_url        = var.rocky_install_url["rocky9"],
        mirror_baseos    = var.rocky_mirror_baseos["rocky9"],
        mirror_appstream = var.rocky_mirror_appstream["rocky9"],
        mirror_extras    = var.rocky_mirror_extras["rocky9"],
        var              = var,
        ssh_public_key   = chomp(file(var.ssh_public_key_file))
      })
    }
    template_name = "rocky9"
    vm_id         = var.vm_id["rocky9"]
  }

  source "proxmox-iso.image" {
    name              = "rocky10"
    boot_command      = var.boot_cmd_rocky10
    boot_key_interval = var.boot_key_interval
    boot_wait         = var.boot_wait
    http_content = { "/anaconda-ks.cfg" = templatefile("configs/anaconda-ks.cfg",
      {
        rocky_url        = var.rocky_install_url["rocky10"],
        mirror_baseos    = var.rocky_mirror_baseos["rocky10"],
        mirror_appstream = var.rocky_mirror_appstream["rocky10"],
        mirror_extras    = var.rocky_mirror_extras["rocky10"],
        var              = var,
        ssh_public_key   = chomp(file(var.ssh_public_key_file))
      })
    }
    template_name = "rocky10"
    vm_id         = var.vm_id["rocky10"]
  }

  provisioner "shell" {
    inline = [
      // clean image identifiers
      "cloud-init clean --machine-id --seed",
      "rm /etc/hostname /etc/ssh/ssh_host_* /var/lib/systemd/random-seed",
      "truncate -s 0 /root/.ssh/authorized_keys",
      "sed -i 's/^#PasswordAuthentication\\ yes/PasswordAuthentication\\ no/' /etc/ssh/sshd_config",
      "sed -i 's/^#PermitRootLogin\\ prohibit-password/PermitRootLogin\\ no/' /etc/ssh/sshd_config"
    ]
  }
}
