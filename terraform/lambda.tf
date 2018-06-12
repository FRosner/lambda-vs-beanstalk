provider "aws" {
  region     = "eu-central-1"
}

resource "aws_lambda_function" "lambda-elb-test-lambda" {
  function_name = "lambda-elb-test"

  s3_bucket = "lambda-elb-test"
  s3_key    = "lambda/de/frosner/elastic-beanstalk-vs-lambda_2.12/0.1-SNAPSHOT/elastic-beanstalk-vs-lambda_2.12-0.1-SNAPSHOT-assembly.jar"

  handler = "de.frosner.elbvsl.lambda.Handler"
  runtime = "java8"

  role = "${aws_iam_role.lambda_exec.arn}"

  memory_size = 1024
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "lambda-elb-test_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
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

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.id}"
  resource_id = "${aws_api_gateway_method.lambda.resource_id}"
  http_method = "${aws_api_gateway_method.lambda.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda-elb-test-lambda.invoke_arn}"
}

resource "aws_api_gateway_deployment" "lambda" {
  depends_on = [
    "aws_api_gateway_integration.lambda"
  ]

  rest_api_id = "${aws_api_gateway_rest_api.lambda-elb-test-lambda.id}"
  stage_name  = "test"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda-elb-test-lambda.arn}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.lambda.execution_arn}/*/*"
}