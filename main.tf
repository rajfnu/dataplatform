resource "aws_security_group" "default_security_group" {
  provider = aws.us-east-1

  vpc_id      = aws_vpc.default_vpc.id
  name        = "default_security_group"
  description = "Allow whitelisted IP in"

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_internet_gateway" "default_gtw" {
  provider = aws.us-east-1

  vpc_id = aws_vpc.default_vpc.id

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_route_table" "default_route" {
  provider = aws.us-east-1

  vpc_id = aws_vpc.default_vpc.id

  route {
    gateway_id = aws_internet_gateway.default_gtw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_security_group_rule" "sg_rule_ingress_all" {
  provider = aws.us-east-1

  type              = "ingress"
  to_port           = 0
  security_group_id = aws_security_group.default_security_group.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "${var.ip}/32",
  ]
}

resource "aws_instance" "t2-7ff2172e" {
  provider = aws.us-east-1

  user_data                   = <<-EOF
  #!/bin/bash
  sudo apt-get update
  sudo apt install docker
EOF
  subnet_id                   = aws_subnet.default_subnet.id
  private_ip                  = "192.168.0.28"
  monitoring                  = false
  key_name                    = aws_key_pair.default_key_pair.id
  instance_type               = "t2.medium"
  ebs_optimized               = false
  availability_zone           = "us-east-1a"
  associate_public_ip_address = false
  ami                         = var.debian_ami

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    "Brainboard Template" = "true"
  }

  vpc_security_group_ids = [
    aws_security_group.default_security_group.id,
  ]
}

resource "aws_subnet" "default_subnet" {
  provider = aws.us-east-1

  vpc_id                  = aws_vpc.default_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_vpc" "default_vpc" {
  provider = aws.us-east-1

  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = "192.168.0.0/24"

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_security_group_rule" "sg_rule_ingress_ssh" {
  provider = aws.us-east-1

  type              = "ingress"
  to_port           = 22
  self              = true
  security_group_id = aws_security_group.default_security_group.id
  protocol          = "tcp"
  from_port         = 22
}

resource "aws_key_pair" "default_key_pair" {
  provider = aws.us-east-1

  public_key = var.public_key

  tags = {
    "Brainboard Template" = "true"
  }
}

resource "aws_instance" "t2-bastion" {
  provider = aws.us-east-1

  subnet_id                   = aws_subnet.default_subnet.id
  source_dest_check           = true
  monitoring                  = true
  key_name                    = aws_key_pair.default_key_pair.id
  instance_type               = "t2.medium"
  ebs_optimized               = false
  availability_zone           = "us-east-1a"
  associate_public_ip_address = true
  ami                         = var.debian_ami

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    "Brainboard Template" = "true"
  }

  vpc_security_group_ids = [
    aws_security_group.default_security_group.id,
  ]
}

resource "aws_route_table_association" "default_route_table_association" {
  provider = aws.us-east-1

  subnet_id      = aws_subnet.default_subnet.id
  route_table_id = aws_route_table.default_route.id
}

resource "aws_security_group_rule" "sg_rule_egress_all" {
  provider = aws.us-east-1

  type              = "egress"
  to_port           = 0
  security_group_id = aws_security_group.default_security_group.id
  protocol          = "-1"
  from_port         = 0

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_network_acl" "default_network_acl" {
  provider = aws.us-east-1

  vpc_id = aws_vpc.default_vpc.id

  egress {
    to_port    = 0
    rule_no    = 100
    protocol   = "-1"
    from_port  = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  ingress {
    to_port    = 0
    rule_no    = 100
    protocol   = "-1"
    from_port  = 0
    cidr_block = "0.0.0.0/0"
    action     = "allow"
  }

  subnet_ids = [
    aws_subnet.default_subnet.id,
  ]

  tags = {
    "Brainboard Template" = "true"
  }
}