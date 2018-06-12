provider "aws" {
  region     = "eu-central-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "lambda-elb-test"
  acl    = "private"
}

resource "aws_lambda_function" "example" {
  function_name = "lambda-elb-test"

  s3_bucket = "${aws_s3_bucket.bucket.bucket}"
  s3_key    = "lambda/de/frosner/elastic-beanstalk-vs-lambda_2.12/0.1-SNAPSHOT/elastic-beanstalk-vs-lambda_2.12-0.1-SNAPSHOT.jar"

  handler = "de.frosner.elbvsl.lambda.Main::getCustomers"
  runtime = "java8"

  role = "${aws_iam_role.lambda_exec.arn}"
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

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