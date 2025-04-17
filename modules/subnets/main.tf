resource "aws_subnet" "subnets" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = contains(var.public_subnet_indexes, count.index)

  tags = merge(var.tags, {
    Name = "${var.prefixo}-subnet-${count.index + 1}"
  })
}
