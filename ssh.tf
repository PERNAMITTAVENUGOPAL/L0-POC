resource "aws_key_pair" "dummy_ssh_venugopal" {
  key_name   = "dummy_ssh_venugopal"
  public_key = file("../ssh/ssh_venugopal.pub")
}