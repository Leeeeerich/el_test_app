import 'package:http_logger/http_logger.dart';
import 'package:http_middleware/http_middleware.dart';

HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
  HttpLogger(logLevel: LogLevel.BODY),
], requestTimeout: Duration(seconds: 30));
