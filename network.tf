resource "aws_vpc" "roboshop_vpc" {
    cidr_block                           = var.cidr_block
    enable_dns_hostnames                 = var.enable_dns_hostnames
    enable_dns_support                   = var.enable_dns_support
    tags = merge(var.common_tags,
                                           {
                                            Name="${var.project_name}-${var.env}" #If you actually want something like roboshop-dev (project name + environment), then you need to concatenate strings properly
                                           })
}

resource "aws_internet_gateway" "roboshop_igw" {
    vpc_id = aws_vpc.roboshop_vpc.id
    tags   = merge(var.common_tags,
            {
            Name="${var.project_name}-${var.env}" #If you actually want something like roboshop-dev (project name + environment), then you need to concatenate strings properly
            })
}

# Public Subnet =2  ,public 1=10.2.0.0/26 ,public 2=10.0.0.64/26 ---- variable=[10.2.0.0/26,10.0.0.64/26]---leanth(variable)=2
resource "aws_subnet" "public_roboshop_subnet" {
    count                          = length(var.public_subnet_cidr)
    vpc_id                         = aws_vpc.roboshop_vpc.id
    cidr_block                     = var.public_subnet_cidr[count.index]
    availability_zone              = local.azs[count.index]
    map_public_ip_on_launch  = true
    tags = merge(var.common_tags,
                                    {
                                    Name="${var.project_name}-${var.env}-public-${local.azs[count.index]}"
                                    })
}

# Private Subnet =2
resource "aws_subnet" "private_roboshop_subnet" {
    count                          = length(var.private_subnet_cidr)
    vpc_id                         = aws_vpc.roboshop_vpc.id
    cidr_block                     = var.private_subnet_cidr[count.index]
    availability_zone              = local.azs[count.index]
    tags = merge(var.common_tags,
                                    {
                                    Name="${var.project_name}-${var.env}-Private-${local.azs[count.index]}"
                                    })
}


resource "aws_route_table" "public_roboshop_route_table" {
    vpc_id = aws_vpc.roboshop_vpc.id
    tags = merge(var.common_tags,
                                    {
                                    Name="${var.project_name}-${var.env}-public"
                                    })
}


resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_roboshop_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.roboshop_igw.id
}

resource "aws_eip" "nat" {
  domain   = "vpc"
}
resource "aws_nat_gateway" "roboshop_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_roboshop_subnet[0].id
  tags = merge(var.common_tags,
                                    {
                                    Name="${var.project_name}-${var.env}-public"
                                    })
  depends_on = [aws_internet_gateway.roboshop_igw]
}

resource "aws_route_table" "private_roboshop_route_table" {
    vpc_id = aws_vpc.roboshop_vpc.id
    tags = merge(var.common_tags,
                                    {
                                    Name="${var.project_name}-${var.env}-private"
                                    })
}

resource "aws_route" "private_route" {
    route_table_id         = aws_route_table.private_roboshop_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.roboshop_nat.id
}

resource "aws_route_table_association" "public_subnet" {
    count          = length(aws_subnet.public_roboshop_subnet)
    subnet_id      = element(aws_subnet.public_roboshop_subnet[*].id,count.index)
    route_table_id = aws_route_table.public_roboshop_route_table.id
}

resource "aws_route_table_association" "private_subnet" {
    count          = length(aws_subnet.private_roboshop_subnet)
    subnet_id      = element(aws_subnet.private_roboshop_subnet[*].id,count.index)
    route_table_id = aws_route_table.private_roboshop_route_table.id
}

# resource "aws_route_table_association" "roboshop_route_table_association" {
#     subnet_id      = aws_subnet.roboshop_subnet.id
#     route_table_id = aws_route_table.roboshop_route_table.id
# }