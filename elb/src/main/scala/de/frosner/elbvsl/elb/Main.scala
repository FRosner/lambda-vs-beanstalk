package de.frosner.elbvsl.elb

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import akka.stream.ActorMaterializer
import com.typesafe.config.ConfigFactory

import scala.util.{Failure, Success, Try}

object Main extends App {

  implicit val system = ActorSystem("my-system")
  implicit val materializer = ActorMaterializer()
  // needed for the future flatMap/onComplete in the end
  implicit val executionContext = system.dispatcher

  val route =
    path("question") {
      complete(42.toString)
    }

  val config = ConfigFactory.load()
  val interface = "0.0.0.0"
  val port = Try(System.getenv("PORT").toInt) match {
    case Success(i) => i
    case Failure(t) =>
      println("Failed to read $PORT: " + t)
      println(s"Using default port: 80")
      80
  }
  val bindingFuture = Http().bindAndHandle(route, interface, port)
  println(s"Server online at http://$interface:$port/")

}
