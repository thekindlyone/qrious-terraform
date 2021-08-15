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

  provisioner "file" {
    source      = "project/"
    destination = "/home/ec2-user"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/scripts/1_install.sh",
      "chmod +x /home/ec2-user/scripts/2_run.sh",
      "/home/ec2-user/scripts/1_install.sh",
    ]

  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable project.service",
      "sudo systemctl start project.service"
    ]
  }
  connection {
    user        = "ec2-user"
    private_key = file("${var.key_name}.pem")
    host        = self.public_ip
  }

}
