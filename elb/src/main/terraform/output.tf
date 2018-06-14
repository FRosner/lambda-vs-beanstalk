output "aws_command" {
  value = "aws elasticbeanstalk update-environment --application-name ${aws_elastic_beanstalk_application.lambda-elb-test.name} --version-label ${aws_elastic_beanstalk_application_version.default.name} --environment-name ${aws_elastic_beanstalk_environment.lambda-elb-test.name}"
}