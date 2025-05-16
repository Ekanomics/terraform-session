resource "aws_key_pair" "main" {
  key_name   = "terraform-key"
  public_key = file("C:/Users/karik/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "main" {
    name = "main"
    description = "this is a security group for ec2"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}


resource "aws_instance" "ec2" {
  depends_on = [ null_resource.main ]                     # Explicit dependancy
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]   # Imlicit dependancy
  key_name = aws_key_pair.main.id                         # Imlicit dependancy

  provisioner "file" {
    source = "C:/Users/karik/Desktop/2025 Cloud & Devops/Github/terraform-session/Session-8/index.html"      # local path, The path where your file exist, local machine
    destination = "/tmp/index.html"                                                                          # remote path, the path where you send the file to
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    host = aws_instance.ec2.public_ip                   # Making reference to itself, as we don't know public IP yet
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo dnf install httpd -y",
        "sudo systemctl enable httpd",
        "sudo systemctl start httpd",
        "sudo cp /tmp/index.html /var/www/html/index.html"
     ]
    connection {
    type = "ssh"
    user = "ec2-user"
    host = self.public_ip
    private_key = file("~/.ssh/id_ed25519")
    }
  }
}


resource "null_resource" "main" {
  provisioner "local-exec" {
    command = "echo 'testing Local Exec' > index.html"
  } 
}