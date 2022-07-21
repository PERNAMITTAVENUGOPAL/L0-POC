resource "local_file" "machine_address" {
    content  = aws_instance.ansible_venugopal.public_ip
    filename = "../ansible/machineIp"
}