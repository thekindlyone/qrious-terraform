data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  # the public SSH key
  key_name = var.key_name

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/${var.INSTANCE_USERNAME}/docker_tail",
    ]
  }
  provisioner "file" {
    source      = "scripts/1_install.sh"
    destination = "/home/${var.INSTANCE_USERNAME}/1_install.sh"
  }
  provisioner "file" {
    source      = "scripts/2_run.sh"
    destination = "/home/${var.INSTANCE_USERNAME}/2_run.sh"
  }
  provisioner "file" {
    source      = "scripts/docker_tail.py"
    destination = "/home/${var.INSTANCE_USERNAME}/docker_tail/docker_tail.py"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.INSTANCE_USERNAME}/1_install.sh",
      "/home/${var.INSTANCE_USERNAME}/1_install.sh",
      # "sudo reboot"
    ]

  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.INSTANCE_USERNAME}/2_run.sh",
      "/home/${var.INSTANCE_USERNAME}/2_run.sh"
    ]
  }
  connection {
    user        = var.INSTANCE_USERNAME
    private_key = file("${var.key_name}.pem")
    host        = self.public_ip
  }
  # user_data = "${file("script.sh")}"

}
