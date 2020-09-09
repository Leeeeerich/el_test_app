import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/model/repository/repository.dart';
import 'package:flutter/cupertino.dart';

class ChatModel extends ChangeNotifier {
  final Repository _repository;
  List<ChatMessage> _messages = List();

  ChatModel(this._repository);

  List<ChatMessage> get messages => _messages;

  Future sendMessage(ChatMessage message) async {
    _repository.sendMessage(message).then((value) {
      _messages.add(value.result);
      notifyListeners();
    });
  }
}
