variable "version" {
  type = "string"
  default = "0.1-SNAPSHOT"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "elastic-beanstalk-vs-lambda_2.12-${var.version}"
  application = "${aws_elastic_beanstalk_application.lambda-elb-test.name}"
  description = "application version created by terraform"
  bucket      = "${data.aws_s3_bucket.lambda-elb-test.id}"
  key         = "${data.aws_s3_bucket_object.application-jar.key}"
}

data "aws_s3_bucket" "lambda-elb-test" {
  bucket = "lambda-elb-test"
}

data "aws_s3_bucket_object" "application-jar" {
  bucket = "${data.aws_s3_bucket.lambda-elb-test.id}"
  key    = "elb/de/frosner/elastic-beanstalk-vs-lambda_2.12/${var.version}/elastic-beanstalk-vs-lambda_2.12-${var.version}-assembly.jar"
}