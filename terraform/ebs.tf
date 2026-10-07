resource "aws_ebs_volume" "public_data" {
  availability_zone = var.availability_zone
  size              = 10
  type              = "gp3"

  tags = {
    Name = "${var.project_name}-public-ebs"
  }
}

resource "aws_volume_attachment" "public_data" {
  device_name = "/dev/sdf"

  volume_id = aws_ebs_volume.public_data.id

  instance_id = aws_instance.public.id

  force_detach = true
}