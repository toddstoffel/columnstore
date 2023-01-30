resource "local_file" "AnsibleInventory" {
  content = templatefile("terraform_includes/inventory.tmpl",
    {
      publicip1                = aws_eip.mcs1_ip.public_ip,
    }
  )
  filename = "inventory/hosts"
}

resource "local_file" "AnsibleVariables" {
  content = templatefile("terraform_includes/all.tmpl",
    {
      admin_pass               = var.admin_pass,
      admin_user               = var.admin_user,
      aws_access_key           = var.aws_access_key,
      aws_region               = var.aws_region,
      aws_secret_key           = var.aws_secret_key,
      aws_zone                 = var.aws_zone,
      cej_pass                 = var.cej_pass,
      cej_user                 = var.cej_user,
      cmapi_key                = var.cmapi_key
      mariadb_enterprise_token = var.mariadb_enterprise_token,
      mariadb_version          = var.mariadb_version,
      mariadb_port             = var.mariadb_port,
      maxscale_pass            = var.maxscale_pass,
      maxscale_port            = var.maxscale_port,
      maxscale_user            = var.maxscale_user,
      maxscale_version         = var.maxscale_version,
      id1                      = aws_instance.mcs1.id,
    }
  )
  filename = "inventory/group_vars/all.yml"
}

resource "local_file" "AnsibleConfig" {
  content = templatefile("terraform_includes/ansible.tmpl",
    {
      ssh_key_file             = var.ssh_key_file
    }
  )
  filename = "ansible.cfg"
}
