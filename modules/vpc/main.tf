resource "aws_vpc" "ktb_11_chatbot_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "ktb-11-chatbot-vpc"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.ktb_11_chatbot_vpc.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "ktb-11-chatbot-public-a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.ktb_11_chatbot_vpc.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "ktb-11-chatbot-public-c"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.ktb_11_chatbot_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "ktb-11-chatbot-private-a"
  }
}

resource "aws_internet_gateway" "ktb_11_chatbot_igw" {
  vpc_id = aws_vpc.ktb_11_chatbot_vpc.id
  tags = {
    Name = "ktb-11-chatbot-igw"
  }
}

resource "aws_route_table" "ktb_11_chatbot_public_rt" {
  vpc_id = aws_vpc.ktb_11_chatbot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ktb_11_chatbot_igw.id
  }

  tags = {
    Name = "ktb-11-chatbot-public-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.ktb_11_chatbot_public_rt.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.ktb_11_chatbot_public_rt.id
}
