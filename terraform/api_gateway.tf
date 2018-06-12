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

data "aws_iam_policy" "cloudwatch" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_iam_role" "cloudwatch" {
  name = "lambda-elb-test_cloudwatch"

  assume_role_policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"",
      "Effect":"Allow",
      "Principal":{
        "Service":"apigateway.amazonaws.com"
      },
      "Action":"sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.cloudwatch.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "lambda-elb-test" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}

output "url" {
  value = "${aws_api_gateway_deployment.lambda.invoke_url}/${aws_api_gateway_resource.lambda.path_part}"
}