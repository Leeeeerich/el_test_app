import 'package:el_test_app/src/model/repository/repository.dart';
import 'package:flutter/cupertino.dart';

class ChatModel extends ChangeNotifier {
  final Repository _repository;

  ChatModel(this._repository);

}