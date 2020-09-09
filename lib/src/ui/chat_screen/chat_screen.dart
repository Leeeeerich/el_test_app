import 'package:el_test_app/src/model/models/models.dart';
import 'package:el_test_app/src/ui/chat_screen/chat_model.dart';
import 'package:el_test_app/src/ui/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  TextEditingController _textMessage = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getColorFromHex("E5E5E5"),
        appBar: AppBar(
          title: Row(children: <Widget>[
            Image.asset("assets/icons/ic_elomia.png",
                fit: BoxFit.cover, height: 36),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(FlutterI18n.translate(context, "elomia_title"))),
          ]),
          backgroundColor: getColorFromHex("A4B3EA"),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Consumer<ChatModel>(builder: (ctx, model, _) {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: _getMessages(model.messages),
                  )),
                  _inputMessage(model),
                ],
              );
            })));
  }

  List<Widget> _getMessages(List<ChatMessage> rawMessages) {
    var messages = List<Widget>();

    rawMessages.map((e) {
      _messageWidget(e);
    });

    return messages;
  }

  Widget _messageWidget(ChatMessage message) {
    return Card(
      color: message.ip != null ? getColorFromHex("5C74DD") : Colors.white,
      child: Text(message.text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _inputMessage(ChatModel model) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(28)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: TextField(
            controller: _textMessage,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/ic_send.svg",
                  semanticsLabel:
                      FlutterI18n.translate(context, "send_message"),
                ),
                onPressed: () {
                  print("Send");
                  model.sendMessage(ChatMessage.text(_textMessage.text));
                },
              ),
              border: InputBorder.none,
              hintText: FlutterI18n.translate(context, "write_message_hint"),
              hintStyle: TextStyle(
                fontSize: 18,
                color: getColorFromHex("9AADDE"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
