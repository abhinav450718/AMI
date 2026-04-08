packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_name" {
  type    = string
  default = "my-app-ami"
}

source "amazon-ebs" "app_ami" {
  region          = var.aws_region
  instance_type   = var.instance_type
  ami_name        = "${var.ami_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  ami_description = "Custom AMI built via Packer and Jenkins"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }

  ssh_username = "ubuntu"

  tags = {
    Name        = var.ami_name
    BuildBy     = "Packer"
    Environment = "CI"
    BuildDate   = formatdate("YYYY-MM-DD", timestamp())
  }
}

build {
  sources = ["source.amazon-ebs.app_ami"]

  provisioner "shell" {
    script = "packer/scripts/setup.sh"
  }
}
