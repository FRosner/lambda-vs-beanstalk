resource "aws_elastic_beanstalk_environment" "lambda-elb-test" {
  name                = "lambda-elb-test"
  application         = "${aws_elastic_beanstalk_application.lambda-elb-test.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.7.1 running Java 8" #https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html#concepts.platforms.javase

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.elb-profile.name}"
  }
}
