#--------------------------------------------------------------
# My Terraform
#
# Build Web servers
#
# Made by Dmytro Handurskyi
#---------------------------------------------------------------------
provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "ansible-client" {
  count                  = 3
  ami                    = "ami-09439f09c55136ecf" #Amazon linux AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ansible-client.id]
  key_name               = "slaves"
}


resource "aws_security_group" "ansible-client" {
  name        = "Ansible Security group"
  description = "security group"


  ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "Ansible"
  }
}
/*  user_data              = <<EOF
!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Built by Terraform!" > /var/www/html/index.html
echo "<br><font color="green">Hello world ))!" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
}
*/
