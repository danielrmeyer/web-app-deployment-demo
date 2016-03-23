resource "aws_instance" "postgres" {
  instance_type = "m3.large"
  ami = "ami-412dcf21"
  key_name = "${var.ssh_key_name}"
  private_ip = "172.31.32.51"
  subnet_id = "${aws_subnet.main.id}"
  vpc_security_group_ids = [ "${aws_security_group.allow_all_outgoing_traffic.id}", "${aws_security_group.allow_all_ssh_access.id}", "${aws_security_group.postgres_access.id}"]
  depends_on = ["aws_internet_gateway.gw"]

  tags {
    Name = "${var.user_name}_postgres"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup-db.sh"
    destination = "/tmp/provisioning/setup-db.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }
  provisioner "remote-exec" {
    inline = ["sudo bash /tmp/provisioning/setup-db.sh"]
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }
}
