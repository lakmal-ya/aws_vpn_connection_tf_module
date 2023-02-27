<!-- BEGIN_TF_DOCS -->
## AWS Site to Site VPN

By default, instances that you launch into an Amazon VPC can't communicate with your own (remote) network. You can enable access to your remote network from your VPC by creating an AWS Site-to-Site VPN (Site-to-Site VPN) connection, and configuring routing to pass traffic through the connection. Although the term VPN connection is a general term, in this documentation, a VPN connection refers to the connection between your VPC and your own on-premises network. Site-to-Site VPN supports Internet Protocol security (IPsec) VPN connections.

## Site-to-Site VPN limitations

- A Site-to-Site VPN connection has the following limitations.
- IPv6 traffic is not supported for VPN connections on a virtual private gateway.
- An AWS VPN connection does not support Path MTU Discovery.
- In addition, take the following into consideration when you use Site-to-Site VPN.
- When connecting your VPCs to a common on-premises network, we recommend that you use non-overlapping CIDR blocks for your networks.

## Prerequisites
You need the following information to set up and configure the components of a Site-to-Site VPN connection.

| Item | Information |
|------|-------------|
|Customer gateway device|The physical or software device on your side of the VPN connection. You need the vendor (for example, Cisco), platform (for example, ISR Series Routers), and software version (for example, IOS 12.4).|
|Customer gateway|<p>To create the customer gateway resource in AWS, you need the following information:<p><p>- The internet-routable IP address for the device's external interface<p><p>- The type of routing: static or dynamic <p><p>- For dynamic routing, the Border Gateway Protocol (BGP) Autonomous System Number (ASN) <p><p>- (Optional) Private certificate from AWS Private Certificate Authority to authenticate your VPN<p><p>For more information, see Customer gateway options for your Site-to-Site VPN connection.<p>|
|(Optional) The ASN for the AWS side of the BGP session|You specify this when you create a virtual private gateway or transit gateway. If you do not specify a value, the default ASN applies. For more information, see Virtual private gateway.|
|VPN connection	|To create the VPN connection, you need the following information: For static routing, the IP prefixes for your private network. (Optional) Tunnel options for each VPN tunnel. For more information, see Tunnel options for your Site-to-Site VPN connection.|

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.53.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.53.0 |

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.customer_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_vpn_connection.vpn_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection_route.vpn_connection_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection_route) | resource |
| [aws_vpn_gateway.virtual_private_gateways](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway) | resource |
| [aws_vpn_gateway_route_propagation.route_propagation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_gateway_route_propagation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_gateway_bgp_asn"></a> [customer\_gateway\_bgp\_asn](#input\_customer\_gateway\_bgp\_asn) | The ASN of your customer gateway device. The Border Gateway Protocol (BGP) Autonomous System Number (ASN) in the range of 1 – 2,147,483,647 is supported. | `number` | n/a | yes |
| <a name="input_customer_gateway_certificate_arn"></a> [customer\_gateway\_certificate\_arn](#input\_customer\_gateway\_certificate\_arn) | (Optional) The ARN of a private certificate provisioned in AWS Certificate Manager (ACM). | `string` | `null` | no |
| <a name="input_customer_gateway_device_name"></a> [customer\_gateway\_device\_name](#input\_customer\_gateway\_device\_name) | (Optional) Enter a name for the customer gateway device. | `string` | `null` | no |
| <a name="input_customer_gateway_ip_address"></a> [customer\_gateway\_ip\_address](#input\_customer\_gateway\_ip\_address) | Specify the internet-routable IP address for your gateway's external interface; the address must be static and may be behind a device performing network address translation (NAT). | `string` | `null` | no |
| <a name="input_customer_gateway_type"></a> [customer\_gateway\_type](#input\_customer\_gateway\_type) | (Required) The type of customer gateway. The only type AWS supports at this time is "ipsec.1". | `string` | n/a | yes |
| <a name="input_route_propagation_route_table_ids"></a> [route\_propagation\_route\_table\_ids](#input\_route\_propagation\_route\_table\_ids) | (Optional)The IDs of the route tables for which routes from the Virtual Private Gateway will be propagated | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | common tags for vpn resources. | `map(string)` | n/a | yes |
| <a name="input_tunnel1_log_options"></a> [tunnel1\_log\_options](#input\_tunnel1\_log\_options) | (Optional) Options for logging VPN tunnel activity. | <pre>list(object({<br>    log_enabled       = bool   # (Optional) Enable or disable VPN tunnel logging feature. The default is false.<br>    log_group_arn     = string # (Optional) The Amazon Resource Name (ARN) of the CloudWatch log group to send logs to.<br>    log_output_format = string # (Optional) Set log format. Default format is json. Possible values are: json and text. The default is json.<br>  }))</pre> | `[]` | no |
| <a name="input_tunnel2_log_options"></a> [tunnel2\_log\_options](#input\_tunnel2\_log\_options) | (Optional) Options for logging VPN tunnel activity. | <pre>list(object({<br>    log_enabled       = bool   # (Optional) Enable or disable VPN tunnel logging feature. The default is false.<br>    log_group_arn     = string # (Optional) The Amazon Resource Name (ARN) of the CloudWatch log group to send logs to.<br>    log_output_format = string # (Optional) Set log format. Default format is json. Possible values are: json and text. The default is json.<br>  }))</pre> | `[]` | no |
| <a name="input_virtual_private_gateways_amazon_side_asn"></a> [virtual\_private\_gateways\_amazon\_side\_asn](#input\_virtual\_private\_gateways\_amazon\_side\_asn) | (Optional) The Autonomous System Number (ASN) for the Amazon side of the gateway. If you don't specify an ASN, the virtual private gateway is created with the default ASN. | `number` | `null` | no |
| <a name="input_virtual_private_gateways_availability_zone"></a> [virtual\_private\_gateways\_availability\_zone](#input\_virtual\_private\_gateways\_availability\_zone) | (Optional) The Availability Zone for the virtual private gateway. | `string` | `null` | no |
| <a name="input_virtual_private_gateways_vpc_id"></a> [virtual\_private\_gateways\_vpc\_id](#input\_virtual\_private\_gateways\_vpc\_id) | (Required) A create a virtual private gateway, you must attach it to your VPC | `string` | n/a | yes |
| <a name="input_vpn_connection_enable_acceleration"></a> [vpn\_connection\_enable\_acceleration](#input\_vpn\_connection\_enable\_acceleration) | (Optional, Default false) Indicate whether to enable acceleration for the VPN connection. Supports only EC2 Transit Gateway. | `bool` | `false` | no |
| <a name="input_vpn_connection_local_ipv4_network_cidr"></a> [vpn\_connection\_local\_ipv4\_network\_cidr](#input\_vpn\_connection\_local\_ipv4\_network\_cidr) | (Optional, Default 0.0.0.0/0) The IPv4 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `null` | no |
| <a name="input_vpn_connection_local_ipv6_network_cidr"></a> [vpn\_connection\_local\_ipv6\_network\_cidr](#input\_vpn\_connection\_local\_ipv6\_network\_cidr) | (Optional, Default ::/0) The IPv6 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `null` | no |
| <a name="input_vpn_connection_outside_ip_address_type"></a> [vpn\_connection\_outside\_ip\_address\_type](#input\_vpn\_connection\_outside\_ip\_address\_type) | (Optional, Default PublicIpv4) Indicates if a Public S2S VPN or Private S2S VPN over AWS Direct Connect. Valid values are PublicIpv4 \| PrivateIpv4 | `string` | `null` | no |
| <a name="input_vpn_connection_remote_ipv4_network_cidr"></a> [vpn\_connection\_remote\_ipv4\_network\_cidr](#input\_vpn\_connection\_remote\_ipv4\_network\_cidr) | (Optional, Default 0.0.0.0/0) The IPv4 CIDR on the AWS side of the VPN connection. | `string` | `null` | no |
| <a name="input_vpn_connection_remote_ipv6_network_cidr"></a> [vpn\_connection\_remote\_ipv6\_network\_cidr](#input\_vpn\_connection\_remote\_ipv6\_network\_cidr) | (Optional, Default ::/0) The IPv6 CIDR on the customer gateway (on-premises) side of the VPN connection. | `string` | `null` | no |
| <a name="input_vpn_connection_route_destination_cidr_block"></a> [vpn\_connection\_route\_destination\_cidr\_block](#input\_vpn\_connection\_route\_destination\_cidr\_block) | (Required) The CIDR block associated with the local subnet of the customer network. | `list(string)` | n/a | yes |
| <a name="input_vpn_connection_static_routes_only"></a> [vpn\_connection\_static\_routes\_only](#input\_vpn\_connection\_static\_routes\_only) | (Optional, Default false) Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP. | `bool` | `false` | no |
| <a name="input_vpn_connection_transit_gateway_id"></a> [vpn\_connection\_transit\_gateway\_id](#input\_vpn\_connection\_transit\_gateway\_id) | (Optional) The ID of the EC2 Transit Gateway. | `string` | `null` | no |
| <a name="input_vpn_connection_transport_transit_gateway_attachment_id"></a> [vpn\_connection\_transport\_transit\_gateway\_attachment\_id](#input\_vpn\_connection\_transport\_transit\_gateway\_attachment\_id) | (Required when outside\_ip\_address\_type is set to PrivateIpv4). The attachment ID of the Transit Gateway attachment to Direct Connect Gateway. The ID is obtained through a data source only. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_dpd_timeout_action"></a> [vpn\_connection\_tunnel1\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel1\_dpd\_timeout\_action) | (Optional, Default clear) The action to take after DPD timeout occurs for the first VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel1_dpd_timeout_seconds"></a> [vpn\_connection\_tunnel1\_dpd\_timeout\_seconds](#input\_vpn\_connection\_tunnel1\_dpd\_timeout\_seconds) | (Optional, Default 30) The number of seconds after which a DPD timeout occurs for the second VPN tunnel. Valid value is equal or higher than 30. | `number` | `null` | no |
| <a name="input_vpn_connection_tunnel1_ike_versions"></a> [vpn\_connection\_tunnel1\_ike\_versions](#input\_vpn\_connection\_tunnel1\_ike\_versions) | (Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2. | `set(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_inside_cidr"></a> [vpn\_connection\_tunnel1\_inside\_cidr](#input\_vpn\_connection\_tunnel1\_inside\_cidr) | (Optional) The CIDR block of the inside IP addresses for the first VPN tunnel. Valid value is a size /30 CIDR block from the 169.254.0.0/16 range. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_inside_ipv6_cidr"></a> [vpn\_connection\_tunnel1\_inside\_ipv6\_cidr](#input\_vpn\_connection\_tunnel1\_inside\_ipv6\_cidr) | (Optional) The range of inside IPv6 addresses for the first VPN tunnel. Supports only EC2 Transit Gateway. Valid value is a size /126 CIDR block from the local fd00::/8 range. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase1\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `set(number)` | <pre>[<br>  2,<br>  14,<br>  15,<br>  16,<br>  17,<br>  18,<br>  19,<br>  20,<br>  21,<br>  22,<br>  23,<br>  24<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `set(string)` | <pre>[<br>  "AES128",<br>  "AES256",<br>  "AES128-GCM-16",<br>  "AES256-GCM-16"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase1\_integrity\_algorithms) | (Optional) One or more integrity algorithms that are permitted for the first VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `set(string)` | <pre>[<br>  "SHA1",<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase1_lifetime_seconds"></a> [vpn\_connection\_tunnel1\_phase1\_lifetime\_seconds](#input\_vpn\_connection\_tunnel1\_phase1\_lifetime\_seconds) | (Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 28800. | `number` | `28800` | no |
| <a name="input_vpn_connection_tunnel1_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel1\_phase2\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `set(number)` | <pre>[<br>  2,<br>  5,<br>  14,<br>  15,<br>  16,<br>  17,<br>  18,<br>  19,<br>  20,<br>  21,<br>  22,<br>  23,<br>  24<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | <pre>[<br>  "AES128",<br>  "AES256",<br>  "AES128-GCM-16",<br>  "AES256-GCM-16"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel1\_phase2\_integrity\_algorithms) | (Optional) List of one or more integrity algorithms that are permitted for the first VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | <pre>[<br>  "SHA1",<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel1_phase2_lifetime_seconds"></a> [vpn\_connection\_tunnel1\_phase2\_lifetime\_seconds](#input\_vpn\_connection\_tunnel1\_phase2\_lifetime\_seconds) | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the first VPN tunnel, in seconds. Valid value is between 900 and 3600. | `number` | `3600` | no |
| <a name="input_vpn_connection_tunnel1_preshared_key"></a> [vpn\_connection\_tunnel1\_preshared\_key](#input\_vpn\_connection\_tunnel1\_preshared\_key) | (Optional) The preshared key of the first VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero(0). Allowed characters are alphanumeric characters, periods(.) and underscores(\_). | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel1_rekey_fuzz_percentage"></a> [vpn\_connection\_tunnel1\_rekey\_fuzz\_percentage](#input\_vpn\_connection\_tunnel1\_rekey\_fuzz\_percentage) | (Optional, Default 100) The percentage of the rekey window for the first VPN tunnel (determined by tunnel1\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100. | `number` | `100` | no |
| <a name="input_vpn_connection_tunnel1_rekey_margin_time_seconds"></a> [vpn\_connection\_tunnel1\_rekey\_margin\_time\_seconds](#input\_vpn\_connection\_tunnel1\_rekey\_margin\_time\_seconds) | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the first VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel1\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel1\_phase2\_lifetime\_seconds. | `number` | `540` | no |
| <a name="input_vpn_connection_tunnel1_replay_window_size"></a> [vpn\_connection\_tunnel1\_replay\_window\_size](#input\_vpn\_connection\_tunnel1\_replay\_window\_size) | (Optional, Default 1024) The number of packets in an IKE replay window for the first VPN tunnel. Valid value is between 64 and 2048. | `number` | `1024` | no |
| <a name="input_vpn_connection_tunnel1_startup_action"></a> [vpn\_connection\_tunnel1\_startup\_action](#input\_vpn\_connection\_tunnel1\_startup\_action) | (Optional, Default add) The action to take when the establishing the tunnel for the first VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |
| <a name="input_vpn_connection_tunnel2_dpd_timeout_action"></a> [vpn\_connection\_tunnel2\_dpd\_timeout\_action](#input\_vpn\_connection\_tunnel2\_dpd\_timeout\_action) | (Optional, Default clear) The action to take after DPD timeout occurs for the second VPN tunnel. Specify restart to restart the IKE initiation. Specify clear to end the IKE session. Valid values are clear \| none \| restart. | `string` | `"clear"` | no |
| <a name="input_vpn_connection_tunnel2_dpd_timeout_seconds"></a> [vpn\_connection\_tunnel2\_dpd\_timeout\_seconds](#input\_vpn\_connection\_tunnel2\_dpd\_timeout\_seconds) | (Optional, Default 30) The number of seconds after which a DPD timeout occurs for the second VPN tunnel. Valid value is equal or higher than 30. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_ike_versions"></a> [vpn\_connection\_tunnel2\_ike\_versions](#input\_vpn\_connection\_tunnel2\_ike\_versions) | (Optional) The IKE versions that are permitted for the first VPN tunnel. Valid values are ikev1 \| ikev2. | `set(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_inside_cidr"></a> [vpn\_connection\_tunnel2\_inside\_cidr](#input\_vpn\_connection\_tunnel2\_inside\_cidr) | (Optional) The CIDR block of the inside IP addresses for the second VPN tunnel. Valid value is a size /30 CIDR block from the 169.254.0.0/16 range. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_inside_ipv6_cidr"></a> [vpn\_connection\_tunnel2\_inside\_ipv6\_cidr](#input\_vpn\_connection\_tunnel2\_inside\_ipv6\_cidr) | (Optional) The range of inside IPv6 addresses for the second VPN tunnel. Supports only EC2 Transit Gateway. Valid value is a size /126 CIDR block from the local fd00::/8 range. | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_phase1_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase1\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are 2 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `set(number)` | <pre>[<br>  2,<br>  14,<br>  15,<br>  16,<br>  17,<br>  18,<br>  19,<br>  20,<br>  21,<br>  22,<br>  23,<br>  24<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase1_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `set(string)` | <pre>[<br>  "AES128",<br>  "AES256",<br>  "AES128-GCM-16",<br>  "AES256-GCM-16"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase1_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase1\_integrity\_algorithms) | (Optional) One or more integrity algorithms that are permitted for the second VPN tunnel for phase 1 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `set(string)` | <pre>[<br>  "SHA1",<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase1_lifetime_seconds"></a> [vpn\_connection\_tunnel2\_phase1\_lifetime\_seconds](#input\_vpn\_connection\_tunnel2\_phase1\_lifetime\_seconds) | (Optional, Default 28800) The lifetime for phase 1 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 28800. | `number` | `28800` | no |
| <a name="input_vpn_connection_tunnel2_phase2_dh_group_numbers"></a> [vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers](#input\_vpn\_connection\_tunnel2\_phase2\_dh\_group\_numbers) | (Optional) List of one or more Diffie-Hellman group numbers that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are 2 \| 5 \| 14 \| 15 \| 16 \| 17 \| 18 \| 19 \| 20 \| 21 \| 22 \| 23 \| 24. | `set(number)` | <pre>[<br>  2,<br>  5,<br>  14,<br>  15,<br>  16,<br>  17,<br>  18,<br>  19,<br>  20,<br>  21,<br>  22,<br>  23,<br>  24<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase2_encryption_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_encryption\_algorithms) | (Optional) List of one or more encryption algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are AES128 \| AES256 \| AES128-GCM-16 \| AES256-GCM-16. | `list(string)` | <pre>[<br>  "AES128",<br>  "AES256",<br>  "AES128-GCM-16",<br>  "AES256-GCM-16"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase2_integrity_algorithms"></a> [vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms](#input\_vpn\_connection\_tunnel2\_phase2\_integrity\_algorithms) | (Optional) List of one or more integrity algorithms that are permitted for the second VPN tunnel for phase 2 IKE negotiations. Valid values are SHA1 \| SHA2-256 \| SHA2-384 \| SHA2-512. | `list(string)` | <pre>[<br>  "SHA1",<br>  "SHA2-256",<br>  "SHA2-384",<br>  "SHA2-512"<br>]</pre> | no |
| <a name="input_vpn_connection_tunnel2_phase2_lifetime_seconds"></a> [vpn\_connection\_tunnel2\_phase2\_lifetime\_seconds](#input\_vpn\_connection\_tunnel2\_phase2\_lifetime\_seconds) | (Optional, Default 3600) The lifetime for phase 2 of the IKE negotiation for the second VPN tunnel, in seconds. Valid value is between 900 and 3600. | `number` | `3600` | no |
| <a name="input_vpn_connection_tunnel2_preshared_key"></a> [vpn\_connection\_tunnel2\_preshared\_key](#input\_vpn\_connection\_tunnel2\_preshared\_key) | (Optional) The preshared key of the second VPN tunnel. The preshared key must be between 8 and 64 characters in length and cannot start with zero(0). Allowed characters are alphanumeric characters, periods(.) and underscores(\_). | `string` | `null` | no |
| <a name="input_vpn_connection_tunnel2_rekey_fuzz_percentage"></a> [vpn\_connection\_tunnel2\_rekey\_fuzz\_percentage](#input\_vpn\_connection\_tunnel2\_rekey\_fuzz\_percentage) | (Optional, Default 100) The percentage of the rekey window for the second VPN tunnel (determined by tunnel2\_rekey\_margin\_time\_seconds) during which the rekey time is randomly selected. Valid value is between 0 and 100. | `number` | `100` | no |
| <a name="input_vpn_connection_tunnel2_rekey_margin_time_seconds"></a> [vpn\_connection\_tunnel2\_rekey\_margin\_time\_seconds](#input\_vpn\_connection\_tunnel2\_rekey\_margin\_time\_seconds) | (Optional, Default 540) The margin time, in seconds, before the phase 2 lifetime expires, during which the AWS side of the second VPN connection performs an IKE rekey. The exact time of the rekey is randomly selected based on the value for tunnel2\_rekey\_fuzz\_percentage. Valid value is between 60 and half of tunnel2\_phase2\_lifetime\_seconds. | `number` | `540` | no |
| <a name="input_vpn_connection_tunnel2_replay_window_size"></a> [vpn\_connection\_tunnel2\_replay\_window\_size](#input\_vpn\_connection\_tunnel2\_replay\_window\_size) | (Optional, Default 1024) The number of packets in an IKE replay window for the second VPN tunnel. Valid value is between 64 and 2048. | `number` | `1024` | no |
| <a name="input_vpn_connection_tunnel2_startup_action"></a> [vpn\_connection\_tunnel2\_startup\_action](#input\_vpn\_connection\_tunnel2\_startup\_action) | (Optional, Default add) The action to take when the establishing the tunnel for the second VPN connection. By default, your customer gateway device must initiate the IKE negotiation and bring up the tunnel. Specify start for AWS to initiate the IKE negotiation. Valid values are add \| start. | `string` | `"add"` | no |
| <a name="input_vpn_connection_tunnel_inside_ip_version"></a> [vpn\_connection\_tunnel\_inside\_ip\_version](#input\_vpn\_connection\_tunnel\_inside\_ip\_version) | (Optional, Default ipv4) Indicate whether the VPN tunnels process IPv4 or IPv6 traffic. Valid values are ipv4 \| ipv6. ipv6 Supports only EC2 Transit Gateway. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_customer_gateway_id"></a> [customer\_gateway\_id](#output\_customer\_gateway\_id) | The ID of the customer gateway to which the connection is attached. |
| <a name="output_tunnel1_address"></a> [tunnel1\_address](#output\_tunnel1\_address) | The public IP address of the first VPN tunnel. |
| <a name="output_tunnel2_address"></a> [tunnel2\_address](#output\_tunnel2\_address) | The public IP address of the second VPN tunnel. |
| <a name="output_vpn_connection_arn"></a> [vpn\_connection\_arn](#output\_vpn\_connection\_arn) | Amazon Resource Name (ARN) of the VPN Connection. |
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | The amazon-assigned ID of the VPN connection. |

## Modules

```
module "aws_vpn_connection" {
  source = "../module"

customer_gateway_bgp_asn = var.customer_gateway_bgp_asn
customer_gateway_ip_address = var.customer_gateway_ip_address
customer_gateway_type = var.customer_gateway_type
customer_gateway_device_name = var.customer_gateway_device_name
customer_gateway_certificate_arn = var.customer_gateway_certificate_arn
tags = var.tags

virtual_private_gateways_vpc_id = var.virtual_private_gateways_vpc_id
virtual_private_gateways_amazon_side_asn  = var.virtual_private_gateways_amazon_side_asn 
virtual_private_gateways_availability_zone = var.virtual_private_gateways_availability_zone
vpn_connection_transit_gateway_id = var.vpn_connection_transit_gateway_id

route_propagation_route_table_ids = var.route_propagation_route_table_ids
vpn_connection_static_routes_only = var.vpn_connection_static_routes_only
vpn_connection_enable_acceleration  = var.vpn_connection_enable_acceleration 
vpn_connection_local_ipv4_network_cidr = var.vpn_connection_local_ipv4_network_cidr
vpn_connection_local_ipv6_network_cidr = var.vpn_connection_local_ipv6_network_cidr
vpn_connection_outside_ip_address_type  = var.vpn_connection_outside_ip_address_type 
vpn_connection_remote_ipv4_network_cidr = var.vpn_connection_remote_ipv4_network_cidr
vpn_connection_remote_ipv6_network_cidr = var.vpn_connection_remote_ipv6_network_cidr
vpn_connection_transport_transit_gateway_attachment_id = var.vpn_connection_transport_transit_gateway_attachment_id

vpn_connection_tunnel_inside_ip_version = var.vpn_connection_tunnel_inside_ip_version
vpn_connection_tunnel1_inside_cidr = var.vpn_connection_tunnel1_inside_cidr
vpn_connection_tunnel2_inside_cidr = var.vpn_connection_tunnel2_inside_cidr
vpn_connection_tunnel1_inside_ipv6_cidr = var.vpn_connection_tunnel1_inside_ipv6_cidr
vpn_connection_tunnel2_inside_ipv6_cidr = var.vpn_connection_tunnel2_inside_ipv6_cidr
vpn_connection_tunnel1_preshared_key = var.vpn_connection_tunnel1_preshared_key
vpn_connection_tunnel2_preshared_key = var.vpn_connection_tunnel2_preshared_key
vpn_connection_tunnel1_dpd_timeout_action  = var.vpn_connection_tunnel1_dpd_timeout_action 
vpn_connection_tunnel2_dpd_timeout_action = var.vpn_connection_tunnel2_dpd_timeout_action
vpn_connection_tunnel1_dpd_timeout_seconds  = var.vpn_connection_tunnel1_dpd_timeout_seconds 
vpn_connection_tunnel2_dpd_timeout_seconds = var.vpn_connection_tunnel2_dpd_timeout_seconds
vpn_connection_tunnel1_ike_versions = var.vpn_connection_tunnel1_ike_versions
vpn_connection_tunnel2_ike_versions  = var.vpn_connection_tunnel2_ike_versions 
tunnel1_log_options = var.tunnel1_log_options
tunnel2_log_options = var.tunnel2_log_options
vpn_connection_tunnel1_phase1_dh_group_numbers = var.vpn_connection_tunnel1_phase1_dh_group_numbers
vpn_connection_tunnel2_phase1_dh_group_numbers = var.vpn_connection_tunnel2_phase1_dh_group_numbers
vpn_connection_tunnel1_phase1_encryption_algorithms = var.vpn_connection_tunnel1_phase1_encryption_algorithms
vpn_connection_tunnel2_phase1_encryption_algorithms = var.vpn_connection_tunnel2_phase1_encryption_algorithms
vpn_connection_tunnel1_phase1_integrity_algorithms = var.vpn_connection_tunnel1_phase1_integrity_algorithms
vpn_connection_tunnel2_phase1_integrity_algorithms = var.vpn_connection_tunnel2_phase1_integrity_algorithms
vpn_connection_tunnel1_phase1_lifetime_seconds = var.vpn_connection_tunnel1_phase1_lifetime_seconds
vpn_connection_tunnel2_phase1_lifetime_seconds = var.vpn_connection_tunnel2_phase1_lifetime_seconds
vpn_connection_tunnel2_phase2_dh_group_numbers  = var.vpn_connection_tunnel2_phase2_dh_group_numbers 
vpn_connection_tunnel1_phase2_dh_group_numbers = var.vpn_connection_tunnel1_phase2_dh_group_numbers
vpn_connection_tunnel1_phase2_encryption_algorithms = var.vpn_connection_tunnel1_phase2_encryption_algorithms
vpn_connection_tunnel2_phase2_encryption_algorithms  = var.vpn_connection_tunnel2_phase2_encryption_algorithms 
vpn_connection_tunnel1_phase2_integrity_algorithms = var.vpn_connection_tunnel1_phase2_integrity_algorithms
vpn_connection_tunnel2_phase2_integrity_algorithms = var.vpn_connection_tunnel2_phase2_integrity_algorithms
vpn_connection_tunnel1_phase2_lifetime_seconds  = var.vpn_connection_tunnel1_phase2_lifetime_seconds 
vpn_connection_tunnel2_phase2_lifetime_seconds = var.vpn_connection_tunnel2_phase2_lifetime_seconds
vpn_connection_tunnel1_rekey_fuzz_percentage  = var.vpn_connection_tunnel1_rekey_fuzz_percentage 
vpn_connection_tunnel2_rekey_fuzz_percentage  = var.vpn_connection_tunnel2_rekey_fuzz_percentage 
vpn_connection_tunnel1_rekey_margin_time_seconds  = var.vpn_connection_tunnel1_rekey_margin_time_seconds 
vpn_connection_tunnel2_rekey_margin_time_seconds = var.vpn_connection_tunnel2_rekey_margin_time_seconds
vpn_connection_tunnel1_replay_window_size  = var.vpn_connection_tunnel1_replay_window_size 
vpn_connection_tunnel2_replay_window_size = var.vpn_connection_tunnel2_replay_window_size
vpn_connection_tunnel1_startup_action = var.vpn_connection_tunnel1_startup_action
vpn_connection_tunnel2_startup_action = var.vpn_connection_tunnel2_startup_action
vpn_connection_route_destination_cidr_block = var.vpn_connection_route_destination_cidr_block

}

```
<!-- END_TF_DOCS -->