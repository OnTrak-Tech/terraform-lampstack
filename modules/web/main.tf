data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.web_security_group_id]
  subnet_id              = var.public_subnet_ids[0]

  user_data = templatefile("${path.module}/user_data.sh", {
    db_username = var.db_username
    db_password = var.db_password
    db_name     = var.db_name
  })

  tags = merge(var.tags, {
    Name = "lamp-web-server"
    Tier = "Web"
  })
}