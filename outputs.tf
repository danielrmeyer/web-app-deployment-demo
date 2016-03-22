output "postgres" {
    value = "${aws_instance.postgres.public_ip}"
}

output "webapp" {
  value = "${aws_instance.webapp.public_ip}"
}

