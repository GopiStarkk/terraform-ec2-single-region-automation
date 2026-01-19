output "instance_ids" {
  value = {
    for k, inst in aws_instance.this :
    k => inst.id
  }
}

output "instance_private_ips" {
  value = {
    for k, inst in aws_instance.this :
    k => inst.private_ip
  }
}
