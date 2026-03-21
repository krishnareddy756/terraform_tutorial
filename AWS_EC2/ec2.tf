#key pair

resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}
#VPC and Security group
resource "aws_default_vpc" "default" {

}
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_default_vpc.default.id
 #inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0/0"]
  }
  ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0/0"]
  }
  ingress{
    from_port=8000
    to_port=8000
    protocol="tcp"
    cidr_blocks=["0.0.0/0"]
    description="Allow HTTP traffic on port 8000"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0/0"]
    description = "Allow all outbound traffic"
  } 
  tags={
    Name = "automate-sg"
  }
}

# ec2 instance

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-05d2d839d4f73aafb" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  tags = {
    Name = "MyEC2Instance"
  }
}