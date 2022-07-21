resource "aws_instance" "ansible_venugopal" {
  depends_on = [
    aws_key_pair.dummy_ssh_venugopal,
    aws_instance.target_venugopal
  ]
  ami           = "ami-04505e74c0741db8d" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.dummy_ssh_venugopal.key_name
  subnet_id = "subnet-092b1745ab4bb5c9e"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_ac_venugopal.id]
  # user_data = <<-EOF
  #   #!/bin/bash
  #   sudo apt update
  #   sudo apt install ansible -y
  # EOF

  tags = {
    Name = "ansible-venugopal"
  }

  connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("../ssh/ssh_venugopal")
      #host = aws_instance.ansible_venugopal.public_ip
      host = self.public_ip
  }

  provisioner "file" {
    source      = "../ssh/ssh_venugopal"
    destination = "/tmp/ssh_venugopal"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt upgrade -y",
      "sudo apt update -y",
      "sudo apt upgrade -y",
      "sudo apt install ansible -y",
      "sudo chmod 666 /etc/ansible/hosts",
      "sudo echo '${aws_instance.target_venugopal.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/etc/ansible/ssh_venugopal ansible_python_interpreter=/usr/bin/python3.8 ansible_ssh_extra_args=\"-o StrictHostKeyChecking=no\"' >> /etc/ansible/hosts",
      "sudo cp /tmp/ssh_venugopal /etc/ansible/ssh_venugopal"
    ]
  }
}

resource "aws_instance" "target_venugopal" {
  depends_on = [
    aws_key_pair.dummy_ssh_venugopal
  ]
  ami           = "ami-04505e74c0741db8d" #ami           = "ami-0e472ba40eb589f49"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.dummy_ssh_venugopal.key_name
  subnet_id = "subnet-092b1745ab4bb5c9e"
  ebs_block_device {
    delete_on_termination = true
    device_name = "/dev/sda1"
    volume_size  = 300
  }
  associate_public_ip_address  = true
  security_groups = [aws_security_group.sg_ts_venugopal.id]

  tags = {
    Name = "target-venugopal"
  }
}
