# Where is our API?

output "url" {
  value = "${aws_api_gateway_deployment.lambda.invoke_url}/${aws_api_gateway_resource.lambda.path_part}"
}