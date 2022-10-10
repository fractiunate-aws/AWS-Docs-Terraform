output "vpc_cidr_block" {
  value = data.aws_vpc.selected.cidr_block
}

# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"
#   vpc_id      = data.aws_vpc.selected.id

#   ingress {
#     description      = "TLS from VPC"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = [data.aws_vpc.selected.cidr_block]
#     ipv6_cidr_blocks = [data.aws_vpc.selected.ipv6_cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "allow_tls"
#   }
# }

# or 

# resource "aws_security_group" "subnet" {
#   vpc_id = data.aws_subnet.selected.vpc_id

#   ingress {
#     cidr_blocks = [data.aws_subnet.selected.cidr_block]
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#   }
# }