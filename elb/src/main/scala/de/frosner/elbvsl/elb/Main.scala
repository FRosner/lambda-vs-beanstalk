package de.frosner.elbvsl.elb

import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import akka.stream.ActorMaterializer
import com.typesafe.config.ConfigFactory

object Main extends App {

  implicit val system = ActorSystem("my-system")
  implicit val materializer = ActorMaterializer()
  // needed for the future flatMap/onComplete in the end
  implicit val executionContext = system.dispatcher

  val route =
    path("customers") {
      complete(List("Frank", "Lars", "Ross", "Paul").mkString(", "))
    }

  val config = ConfigFactory.load()
  val interface = config.getString("http.interface")
  val port = config.getInt("http.port")
  val bindingFuture = Http().bindAndHandle(route, interface, port)
  println(s"Server online at http://$interface:$port/")

}
