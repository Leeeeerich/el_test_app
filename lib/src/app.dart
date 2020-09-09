import 'dart:io';

import 'package:el_test_app/src/model/local_consts.dart';
import 'package:el_test_app/src/model/repository/repository.dart';
import 'package:el_test_app/src/model/repository/repository_impl.dart';
import 'package:el_test_app/src/model/web_api/client.dart';
import 'package:el_test_app/src/model/web_api/web_api.dart';
import 'package:el_test_app/src/model/web_api/web_api_impl.dart';
import 'package:el_test_app/src/ui/chat_screen/chat_model.dart';
import 'package:el_test_app/src/ui/chat_screen/chat_screen.dart';
import 'package:el_test_app/src/ui/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http_middleware/http_middleware.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  App(
      this._flutterI18nDelegate, {
        Key key,
      }) : super(key: key);

  FlutterI18nDelegate _flutterI18nDelegate;

  @override
  _App createState() => _App();
}

class _App extends State<App> {
  HttpWithMiddleware _client;
  WebApi _webApi;
  Repository _repository;

  @override
  void initState() {
    _prepare();
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => ChatModel(_repository)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          widget._flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        initialRoute: Routes.CHAT_SCREEN,
        routes: {
          Routes.CHAT_SCREEN: (ctx) => ChatScreen(),
        },
      ),
    );
  }

  Future<bool> _prepare() async {
    try {
      _client = httpClient;
      _webApi = WebApiImpl(_client);
      _repository = RepositoryImpl(_webApi);
      return true;
    } catch (e) {
      showToast("Init error = $e");
      print("Init error = $e");
      return false;
    }
  }
}