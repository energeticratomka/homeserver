#Buid Webserver during bootstrap

provider "aws" {
  region - "eu-central-1"
}

resource "aws_instanse" "Webserver" {
  ami "ami-0b579bbec4f1176e8"
  instanse_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.Webserver]
  user_data = <<EOF
  #!/bin/bash
  yum -y update
  yum -y install httpd
  myip='curl httpd://169.254.169.254/latest/meta-data/local-ipv4'
  echo "<h2>Webserver with IP: $myip</h2><br>Buil by Terraform" > /var/www/html/index.html
  sudo service httpd start
  chkconfig httpd on
  EOF
}
resource "aws_security_group" "Webserver" {
  name        = "Webserver"
  description = "Allow TCP port inbound traffic"
  
  ingress {
    description      = "TCP port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [0.0.0.0/0]
    
  }
ingress {
    description      = "TCP port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [0.0.0.0/0]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}