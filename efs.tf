resource "aws_efs_file_system" "efs_terra" {
    creation_token = "efs-token"
    performance_mode = "generalPurpose"
    throughput_mode = "bursting"
    encrypted = "true"

    tags = {
        Name = "lab-efs"
    }
}

resource "aws_efs_mount_target" "efs-mt" {
   file_system_id  = aws_efs_file_system.efs_terra.id
   subnet_id = aws_subnet.subnetpriv.id
   security_groups = [aws_security_group.efs_sg.id]
 }
