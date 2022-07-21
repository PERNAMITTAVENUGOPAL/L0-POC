resource "aws_key_pair" "ssh_venugopal" {
  key_name   = "ssh_venugopal"
  public_key = file("../ssh/ssh_venugopal.pub")
}