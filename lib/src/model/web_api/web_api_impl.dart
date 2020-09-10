import 'dart:convert';

import 'package:el_test_app/src/model/local_consts.dart';
import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/web_api/web_api.dart';
import 'package:el_test_app/src/model/web_api/web_utils.dart';
import 'package:http_middleware/http_middleware.dart';

class WebApiImpl implements WebApi {
  final HttpWithMiddleware _client;

  WebApiImpl(this._client);

  @override
  Future<Result<ChatMessage>> sendMessage(ChatMessage message) async {
    int requestStart = DateTime.now().millisecondsSinceEpoch;
    var res = await _client.get(
      "${BaseConstants.BASE_URL}?format=json",
      headers: BaseConstants.HEADERS,
    );

    var chatMessage;
    var statusCode;
    var error;

    if (res.statusCode == 200) {
      chatMessage = /*ChatMessage.fromJson(jsonDecode(res.body));*/
          ChatMessage.text(message.text);
      chatMessage.ip = jsonDecode(res.body)['ip'];
      chatMessage.requestTime =
          DateTime.now().millisecondsSinceEpoch - requestStart;
      statusCode = StatusCode.successful;
    } else {
      error = res.body;
      statusCode = StatusCode.unsuccessfully;
    }

    return Result(chatMessage, statusCode, error: error);
  }
}
