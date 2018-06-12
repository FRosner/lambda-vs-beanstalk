package de.frosner.elbvsl.lambda

case class Response(statusCode: Int,
                    isBase64Encoded: Boolean,
                    headers: Map[String, String],
                    body: String)
