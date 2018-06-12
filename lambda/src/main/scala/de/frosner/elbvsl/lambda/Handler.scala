package de.frosner.elbvsl.lambda

import java.io.{InputStream, OutputStream, PrintStream}

import io.circe.syntax._
import io.circe.generic.auto._
import com.amazonaws.services.lambda.runtime.{Context, RequestStreamHandler}

import scala.io.Source

class Handler extends RequestStreamHandler {
  override def handleRequest(input: InputStream,
                             output: OutputStream,
                             context: Context): Unit = {
    val logger = context.getLogger
    logger.log("Processing request.")
    val inputJsonString = Source.fromInputStream(input).mkString
    logger.log(inputJsonString)
    val result = Response(
      statusCode = 200,
      isBase64Encoded = false,
      headers = Map.empty,
      body = "42"
    ).asJson
    val out = new PrintStream(output)
    out.print(result)
    out.close()
  }
}
