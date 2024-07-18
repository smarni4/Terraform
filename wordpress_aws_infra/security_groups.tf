resource "aws_security_group" "load_balancer" {
  name        = "load-balancer_sg"
  description = "Control access to the load balancer"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "bastion-host-sg" {
  name        = "bastion-host_security_group"
  description = "Allow inbound ssh from any where and outbound ssh into private instances."
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    # To allow ssh into bastion host.
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # To allow ssh into private instances from bastion host.
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "private_instance_SG" {
  name        = "wordpress_private_instance_sg"
  description = "Allow inbound traffic from load-balancer and outbound through NAT and allow local communication. Allows port 3306 to communicate with aurora db"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public_subnet_1a.cidr_block]
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_1a_2.cidr_block, aws_subnet.private_subnet_1b_2.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws_db_sg" {
  name        = "aurora db security group"
  description = "Allows access from ec2 instance running in private subnet"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_subnet_1b_1.cidr_block, aws_subnet.private_subnet_1a_1.cidr_block]
  }
}
