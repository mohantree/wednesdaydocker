data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "public" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.public_1.id

  vpc_security_group_ids = [
    aws_security_group.public_ec2.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-public-ec2"
  }
}

resource "aws_instance" "private" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  subnet_id = aws_subnet.private.id

  vpc_security_group_ids = [
    aws_security_group.private_ec2.id
  ]

  key_name = var.key_name

  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.private_ec2.name

  user_data = <<-EOF
              #!/bin/bash

              apt-get update -y
              apt-get install -y docker.io

              systemctl enable docker
              systemctl start docker

              usermod -aG docker ubuntu

              snap install amazon-ssm-agent --classic

              systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
              systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
              EOF

  tags = {
    Name = "${var.project_name}-private-ec2"
  }
}