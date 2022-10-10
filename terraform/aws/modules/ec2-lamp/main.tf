locals {
  tags = {
    environment = var.environment,
    location    = var.location
    layer       = var.layer
    module      = "ec2-lamp"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "ec2_nwi" {
  subnet_id = var.subnet_id
  #   private_ips = ["172.16.10.100"]

  tags = local.tags
}


resource "aws_instance" "lamp" {
  ami = data.aws_ami.ubuntu.id

  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.ec2_nwi.id
    device_index         = 0
  }
  tags = local.tags

}

# Public Elastic-IP
resource "aws_eip" "lb" {
  instance = aws_instance.lamp.id
  vpc      = true
}
