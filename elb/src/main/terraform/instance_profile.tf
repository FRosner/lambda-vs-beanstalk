resource "aws_iam_role" "elb" {
  name = "lambda-elb-test_elb"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy" "AWSElasticBeanstalkWebTier" {
  arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "elb-attach" {
  role       = "${aws_iam_role.elb.name}"
  policy_arn = "${data.aws_iam_policy.AWSElasticBeanstalkWebTier.arn}"
}

resource "aws_iam_instance_profile" "elb-profile" {
  name = "elb_profile"
  role = "${aws_iam_role.elb.name}"
}
