# Create a Null Resource and Provisioners
resource "null_resource" "name" {
    depends_on = [ module.ec2_public ]
    # Connection Block for Provisioners to connect to EC2 Instance
    connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
    
  }
  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  ## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  
}