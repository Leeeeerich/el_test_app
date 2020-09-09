import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/web_api/web_utils.dart';

abstract class WebApi {
  Future<Result<ChatMessage>> sendMessage(ChatMessage message);
}