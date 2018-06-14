variable "version" {
  type = "string"
  default = "0.1-SNAPSHOT"
}

resource "aws_lambda_function" "lambda-elb-test-lambda" {
  function_name = "lambda-elb-test"

  s3_bucket = "lambda-elb-test"
  s3_key    = "lambda/de/frosner/elastic-beanstalk-vs-lambda_2.12/${var.version}/elastic-beanstalk-vs-lambda_2.12-${var.version}-assembly.jar"

  handler = "de.frosner.elbvsl.lambda.Handler"
  runtime = "java8"

  role = "${aws_iam_role.lambda_exec.arn}"

  memory_size = 1024
}

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