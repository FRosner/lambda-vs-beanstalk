package de.frosner.elbvsl.lambda

import scala.collection.JavaConverters._

object Main {

  def getCustomers: java.util.List[String] =
    List("Frank", "Lars", "Ross", "Paul").asJava

}
