provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzoXcKjiFHe6OTukslVcni9MdiLXkSGbU4nNkiRt27TMSdbfjWigB82twV99NyO8lOs58Fp80wtzoWKdDI/HPA5UfeT/IdTui1hFFrhBz9LCGnrrH5n46eUdPdojjEQtPTKzhqmhOvnwmWiOPvtbM6eTPszlxC0gSxpezdiZ6VPFp5ZYfxbSvvpVAhrRsPVnllLZee47eWMRh2eXlBGlVWUB7Lr5OKz8QSE1lU5HViCTF0fM+2YcRwdANQDEe7pwxB2e3+5hAsUm02X+GmGunUx/ULtMDpgWuRd4IczavY44mY2abarcCRG2c3TKHaTxcPvK1wwHlYsfNufH+IqIkL ubuntu@ubuntu-VirtualBox"
}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "kubernetes-worker" {
  ami           = "ami-02fe94dee086c0c37"
  instance_type = "t2.medium"
  key_name = "k8s-key"
  count = 2
  tags = {
    name = "k8s"
    type = "worker"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master" {
  ami           = "ami-02fe94dee086c0c37"
  instance_type = "t2.medium"
  key_name = "k8s-key"
  count = 1
  tags = {
    name = "k8s"
    type = "master"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}