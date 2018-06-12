resource "aws_api_gateway_rest_api" "lambda-elb-test-lambda" {
  name        = "lambda-elb-test"
  description = "Lambda vs Elastic Beanstalk Lambda Example"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.lambda.invoke_url}"
}