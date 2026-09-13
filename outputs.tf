# outputs for count
# output "ec2_public_ip" {
#   value = aws_instance.my_instance_1[*].public_ip
# }
# output "ec2_public_dns" {
#   value = aws_instance.my_instance_1[*].public_dns
# }
# output "ec2_private_ip" {
#   value = aws_instance.my_instance_1[*].private_ip
# }

#outputs for foreach
output "ec2_public_ip" {
  value = [for instance in aws_instance.my_instance_1 : instance.public_ip]
}
output "ec2_public_dns" {
  value = [for instance in aws_instance.my_instance_1 : instance.public_dns]
}
output "ec2_private_ip" {
  value = [for instance in aws_instance.my_instance_1 : instance.private_ip]
}