output "instance_id" {
  value = aws_instance.this.id
}

output "debug_sg_tag" {
  value = var.sg_tag
}
