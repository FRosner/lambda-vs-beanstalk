## Description

This is the source code of my experimentation with deploying an HTTP API on AWS using either Lambda + API Gateway, or Elastic Beanstalk.

You can find more context and information in the respective blog posts:

- [Deploying an HTTP API on AWS using Lambda and API Gateway
](https://dev.to/frosnerd/deploying-an-http-api-on-aws-using-lambda-and-api-gateway-g61)
- [Deploying an HTTP API on AWS using Elastic Beanstalk
](https://dev.to/frosnerd/deploying-an-http-api-on-aws-using-elastic-beanstalk-5dh7)

## Modules

This project contains two `sbt` modules: `lambda` and `elb`. They both contain more or less the same functionality, but one is used for the Lambda deployment and the other one for deploying on Elastic Beanstalk.

## Publish

- `sbt publish`

## Deploy

- `./terraformw lambda apply`
- `./terraformw elb apply`