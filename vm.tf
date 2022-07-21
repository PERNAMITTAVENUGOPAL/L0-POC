resource "aws_instance" "vm_jenkins_venugopal" {
  depends_on = [
    aws_key_pair.ssh_venugopal,
    aws_security_group.sg_venugopal
  ]
  ami           = "ami-0e472ba40eb589f49" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.ssh_venugopal.key_name
  subnet_id="subnet-092b1745ab4bb5c9e"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_venugopal.id]

  tags = {
    Name = "vm-jenkins-venugopal"
  }

  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ssh/ssh_venugopal")
      #host = aws_instance.vm_venugopal.public_ip
      host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt upgrade -y",
      "sudo apt update -y",
      "sudo apt install openjdk-8-jdk -y",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt upgrade -y",
      "sudo apt update -y",
      "sudo apt install jenkins -y"
      # "systemctl status jenkins"
    ]
  }
}
