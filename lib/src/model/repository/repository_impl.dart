import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/repository/repository.dart';
import 'package:el_test_app/src/model/web_api/web_api.dart';
import 'package:el_test_app/src/model/web_api/web_utils.dart';

class RepositoryImpl implements Repository {
  final WebApi _webApi;
  RepositoryImpl(this._webApi);

  @override
  Future<Result<ChatMessage>> sendMessage(ChatMessage message) {
    return _webApi.sendMessage(message);
  }
}