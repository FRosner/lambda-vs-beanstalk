enablePlugins(JavaAppPackaging)

lazy val root = (project in file("."))
  .settings(
    organization in ThisBuild := "de.frosner",
    scalaVersion in ThisBuild := "2.12.6",
    version      in ThisBuild := "0.1.0-SNAPSHOT",
    mainClass in Compile := Some("de.frosner.elbvsl.Main"),
    name := "elastic-beanstalk-vs-lambda",
    libraryDependencies ++= Dependencies.all
  )
