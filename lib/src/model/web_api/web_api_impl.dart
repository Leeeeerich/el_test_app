import 'dart:convert';

import 'package:el_test_app/src/model/local_consts.dart';
import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/web_api/web_api.dart';
import 'package:el_test_app/src/model/web_api/web_utils.dart';
import 'package:http/http.dart';
import 'package:http_middleware/http_middleware.dart';

class WebApiImpl implements WebApi {
  final HttpWithMiddleware _client;

  WebApiImpl(this._client);

  @override
  Future<Result<ChatMessage>> sendMessage(ChatMessage message) async {
    var res = await _client.get(
      "${BaseConstants.BASE_URL}?format=json",
      headers: BaseConstants.HEADERS,
    );

    print("Response ${res.body}");

    return responseConverter(res);
  }
}

//TODO make universal
responseConverter(Response res) {
  var chatMessage;
  var statusCode;
  var error;

  if (res.statusCode == 200) {
    chatMessage = ChatMessage.fromJson(jsonDecode(res.body));
    statusCode = StatusCode.successful;
  } else {
    error = res.body;
    statusCode = StatusCode.unsuccessfully;
  }

  return Result(chatMessage, statusCode, error: error);
}
