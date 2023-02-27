output "vpn_connection_arn" {
  description = "Amazon Resource Name (ARN) of the VPN Connection."
  value = aws_vpn_connection.vpn_connection.arn
}
output "vpn_connection_id" {
  description = "The amazon-assigned ID of the VPN connection."
  value = aws_vpn_connection.vpn_connection.id
}
output "customer_gateway_id" {
  description = " The ID of the customer gateway to which the connection is attached."
  value = aws_customer_gateway.customer_gateway.id
}
output "tunnel1_address" {
  description = "The public IP address of the first VPN tunnel."
  value = aws_vpn_connection.vpn_connection.tunnel1_address
}
output "tunnel2_address" {
  description = "The public IP address of the second VPN tunnel."
  value = aws_vpn_connection.vpn_connection.tunnel2_address
}