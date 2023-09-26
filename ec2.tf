resource "aws_instance" "efs-server"{
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.subnetpub.id
  associate_public_ip_address = true

  user_data = <<EOF
  #!/bin/bash
  sudo apt install nfs-common -y
  sudo mkdir /efs

  EOF

  tags = {
    Name = "Terra-EC2-1"
  }
}

resource "aws_instance" "efs-client"{
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.subnetpub.id
  associate_public_ip_address = true

  user_data = <<EOF
  #!/bin/bash
  sudo apt install nfs-common -y
  sudo mkdir /efs

  EOF

  tags = {
    Name = "Terra-EC2-2"
  }
}
