resource "aws_security_group" "ec2_sg" {
    name = "terra-ec2-sg"
    description = "Grupo de seguranca dedicado para acesso publico as instancias ec2"
    vpc_id = aws_vpc.terra_vpc.id

    ingress {
        description = "liberando o HTTP"
         from_port = 80
         to_port = 80
         protocol = "tcp"
         cidr_blocks = [aws_vpc.terra_vpc.cidr_block] 
    }

        ingress {
        description = "liberando o HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [aws_vpc.terra_vpc.cidr_block] 
    }
    
    ingress {
        description = "liberando o SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.terra_vpc.cidr_block] 
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = 0 
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name =  "EC2-SG"
    }
}

resource "aws_security_group" "efs_sg"{
    name = "terra-efs-sg"
    description = "Grupo de seguranca dedicado para acesso dos usuarios ao EFS"
    vpc_id = aws_vpc.terra_vpc.id


    ingress{

        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [aws_security_group.ec2_sg.id]
    }
}


