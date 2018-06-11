import sbt._

object Dependencies {
  lazy val all = akkaHttp ++ scalaTest
  lazy val scalaTest = List(
    "org.scalatest" %% "scalatest" % "3.0.1"
  )
  lazy val akkaHttp = List(
    "com.typesafe.akka" %% "akka-actor" % "2.5.12",
    "com.typesafe.akka" %% "akka-stream" % "2.5.11",
    "com.typesafe.akka" %% "akka-http" % "10.1.1"
  )
}
