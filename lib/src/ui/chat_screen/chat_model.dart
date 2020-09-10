import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/repository/repository.dart';
import 'package:flutter/cupertino.dart';

class ChatModel extends ChangeNotifier {
  final Repository _repository;
  List<ChatMessage> _messages = List();

  ChatModel(this._repository);

  List<ChatMessage> get messages => _messages;

  Future<String> sendMessage(ChatMessage message) async {
    _messages.insert(0, message);
    notifyListeners();
    _repository.sendMessage(message).then((value) {
      if (value.isSuccessful) {
        _messages.insert(0, value.result);
        notifyListeners();
      } else {
        return "Error = ${value.error}";
      }
    }).catchError((e) {
      return "Error = $e";
    });
  }
}
