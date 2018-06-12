resource "aws_api_gateway_rest_api" "lambda-elb-test-lambda" {
  name        = "lambda-elb-test"
  description = "Lambda vs Elastic Beanstalk Lambda Example"
}

resource "aws_api_gateway_method_settings" "s" {
  rest_api_id = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.id}"
  stage_name  = "${aws_api_gateway_deployment.lambda.stage_name}"
  method_path = "*/*"

  settings {
    metrics_enabled = false
    logging_level = "OFF" # set to INFO to enable logging
  }
}

resource "aws_api_gateway_resource" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.id}"
  parent_id   = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.root_resource_id}"
  path_part   = "question"
}

resource "aws_api_gateway_method" "lambda" {
  rest_api_id   = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.id}"
  resource_id   = "${aws_api_gateway_resource.lambda.id}"
  http_method   = "ANY"
  authorization = "NONE"
}
