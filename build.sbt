enablePlugins(JavaAppPackaging)

lazy val commonSettings = Seq(
  version := "0.1-SNAPSHOT",
  scalaVersion := "2.12.6",
  organization := "de.frosner",
  name := "elastic-beanstalk-vs-lambda",
  test in assembly := {}
)

lazy val lambda = (project in file("lambda"))
  .settings(commonSettings: _*)
  .settings(
    publishTo := Some("S3" at "s3://s3-eu-central-1.amazonaws.com/lambda-elb-test/lambda"),
    artifact in (Compile, assembly) := {
      val art = (artifact in (Compile, assembly)).value
      art.withClassifier(Some("assembly"))
    },
    addArtifact(artifact in (Compile, assembly), assembly)
  )

lazy val elb = (project in file("elb"))
  .settings(
    libraryDependencies ++= List(
    "com.typesafe.akka" %% "akka-actor" % "2.5.12",
    "com.typesafe.akka" %% "akka-stream" % "2.5.11",
    "com.typesafe.akka" %% "akka-http" % "10.1.1"
    )
  )