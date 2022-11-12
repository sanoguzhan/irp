variable "awsprops" {
    type = map(string)
    default = {
    region = "eu-west-3"
    vpc = "vpc-08c91e4bf12660ea4"
    ami = "ami-064736ff8301af3ee"
    itype = "m5.large"
    subnet = "subnet-0b15f628061e75da6"
    publicip = true
    key_name = "ec2db"
    secgroupname = "IRP-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
  profile = "default"
}

resource "aws_security_group" "project-irp-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH 
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "project-irp" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "key_name")


  vpc_security_group_ids = [
    aws_security_group.project-irp-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="TESTSERVER"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.project-irp-sg ]
}


output "ec2instance" {
  value = aws_instance.project-irp.public_ip
}