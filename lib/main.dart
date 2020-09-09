import 'package:el_test_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
          useCountryCode: false,
          fallbackFile: 'en',
          //forcedLocale: new Locale('ru'),
          basePath: 'assets/locales'));
  WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);

  runApp(App(flutterI18nDelegate));
}
