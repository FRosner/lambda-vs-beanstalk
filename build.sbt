enablePlugins(JavaAppPackaging)

lazy val commonSettings = Seq(
  version := "0.1-SNAPSHOT",
  scalaVersion := "2.12.6",
  organization := "de.frosner",
  name := "elastic-beanstalk-vs-lambda",
  test in assembly := {},
  javacOptions ++= Seq("-source", "1.8", "-target", "1.8")
)

lazy val assemblySettings = Seq(
  artifact in (Compile, assembly) := {
    val art = (artifact in (Compile, assembly)).value
    println(s"xxx ${art}")
    art.withClassifier(Some("assembly"))
  },
  addArtifact(artifact in (Compile, assembly), assembly)
)

def publishToS3(folder: String) =
  publishTo := Some("S3" at s"s3://s3-eu-central-1.amazonaws.com/lambda-elb-test/$folder")

lazy val lambda = (project in file("lambda"))
  .settings(commonSettings: _*)
  .settings(assemblySettings: _*)
  .settings(
    publishToS3("lambda"),
    libraryDependencies ++= List(
      "com.amazonaws" % "aws-java-sdk-lambda" % "1.11.344",
      "com.amazonaws" % "aws-lambda-java-core" % "1.2.0",
    ) ++ List(
      "io.circe" %% "circe-core",
      "io.circe" %% "circe-generic",
      "io.circe" %% "circe-parser").map(_ % "0.9.3")
  )

lazy val elb = (project in file("elb"))
  .settings(commonSettings: _*)
  .settings(assemblySettings: _*)
  .settings(
    publishToS3("elb"),
    mainClass in assembly := Some("de.frosner.elbvsl.elb.Main"),
    libraryDependencies ++= List(
      "com.typesafe.akka" %% "akka-actor" % "2.5.12",
      "com.typesafe.akka" %% "akka-stream" % "2.5.11",
      "com.typesafe.akka" %% "akka-http" % "10.1.1"
    )
  )