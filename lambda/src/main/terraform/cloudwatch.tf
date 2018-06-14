# Cloudwatch policies and roles required to get API Gateway logs

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
  policy_arn = "${data.aws_iam_policy.cloudwatch.arn}"
}

resource "aws_api_gateway_account" "lambda-elb-test" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}