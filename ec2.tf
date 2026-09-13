# key pair for login
resource "aws_key_pair" "my_key_1" {
  key_name   = "${var.env}-terra-key-ec2-3"
  public_key = file("terra-key-ec2-3.pub")

  tags = {
    Environment = var.env
  }

}
# VPC & Security group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_sg_1" {
  name        = "${var.env}-automate-sg-3"
  description = "this will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id #interpolation

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH from anywhere"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }
  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "${var.env}-automate-sg-3"
    Environment = var.env
  }
}
# ec2 instance
resource "aws_instance" "my_instance_1" {
#   count = 2
  for_each = tomap({
    shub_instance_1 = "t2.micro"

  }) # meta argument

  depends_on = [aws_security_group.my_sg_1]

  key_name        = aws_key_pair.my_key_1.key_name
  security_groups = [aws_security_group.my_sg_1.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2_root_default_storage_size
    volume_type = "gp3"
  }
  tags = {
    Name = each.key
    Environment = var.env
  }
}
