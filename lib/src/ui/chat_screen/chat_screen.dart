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
  TextEditingController _editTextMessageController = TextEditingController();
  var _scrollController = ScrollController();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getColorFromHex("E5E5E5"),
        appBar: AppBar(
          title: Row(children: <Widget>[
            Image.asset("assets/icons/ic_robot.png",
                fit: BoxFit.cover, height: 36),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(FlutterI18n.translate(context, "app_title"))),
          ]),
          backgroundColor: getColorFromHex("A4B3EA"),
        ),
        body: Consumer<ChatModel>(builder: (ctx, model, _) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _emptyScreenOrList(model),
              _inputMessage(model),
            ],
          );
        }));
  }

  Widget _emptyScreenOrList(ChatModel model) {
    var widget;

    if (model.messages.isEmpty) {
      widget = Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(FlutterI18n.translate(context, "empty_screen_message"),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, color: getColorFromHex("9AADDE"))),
        ),
      );
    } else {
      widget = Padding(
        padding: EdgeInsets.only(bottom: LIST_BOTTOM_PADDING),
        child: ListView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          reverse: true,
          padding: EdgeInsets.only(bottom: LIST_BOTTOM_CLIP_PADDING),
          children: _getMessages(model.messages),
        ),
      );
    }

    return widget;
  }

  List<Widget> _getMessages(List<ChatMessage> rawMessages) {
    var messages = List<Widget>();
    print("Messages size = ${rawMessages.length}");
    rawMessages.forEach((e) {
      messages.add(_messageWidget(e));
    });

    return messages;
  }

  Widget _messageWidget(ChatMessage message) {
    return Wrap(
        alignment: message.ip != null ? WrapAlignment.start : WrapAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                message.ip != null
                    ? HORIZONTAL_PADDING_FROM_EDGE
                    : EXTRA_HORIZONTAL_PADDING,
                0,
                message.ip != null
                    ? EXTRA_HORIZONTAL_PADDING
                    : HORIZONTAL_PADDING_FROM_EDGE,
                HORIZONTAL_PADDING_FROM_EDGE),
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  message.ip != null
                      ? "Text = ${message.text}\n IP = ${message.ip} \n PING = ${message.requestTime} ms"
                      : message.text,
                  style: TextStyle(
                    fontSize: MESSAGE_TEXT_SIZE,
                    color: message.ip != null
                        ? getColorFromHex("07144A")
                        : Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: message.ip != null
                    ? Colors.white
                    : getColorFromHex("5C74DD"),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(message.ip != null ? 0 : MESSAGE_CORNERS),
                  topRight: Radius.circular(MESSAGE_CORNERS),
                  bottomLeft: Radius.circular(MESSAGE_CORNERS),
                  bottomRight:
                      Radius.circular(message.ip != null ? MESSAGE_CORNERS : 0),
                ),
              ),
            ),
          )
        ]);
  }

  Widget _inputMessage(ChatModel model) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        EDIT_MESSAGE_PADDING,
        0,
        EDIT_MESSAGE_PADDING,
        EDIT_MESSAGE_PADDING,
      ),
      child: Wrap(children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          // height: EDIT_MESSAGE_HEIGHT,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(EDIT_MESSAGE_CORNERS)),
            color: Colors.white,
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: EDIT_MESSAGE_PADDING_TEXT),
            child: Center(
              child: TextFormField(
                minLines: 1,
                maxLines: 7,
                style: TextStyle(fontSize: EDIT_MESSAGE_TEXT_SIZE),
                controller: _editTextMessageController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      "assets/icons/ic_send.svg",
                      semanticsLabel:
                          FlutterI18n.translate(context, "send_message"),
                    ),
                    onPressed: () {
                      if (_editTextMessageController.text.isEmpty) return;
                      model
                          .sendMessage(
                              ChatMessage.text(_editTextMessageController.text))
                          .then((value) {
                        if (value != null) showToast(value);
                      });
                      _editTextMessageController.clear();
                    },
                  ),
                  border: InputBorder.none,
                  hintText:
                      FlutterI18n.translate(context, "write_message_hint"),
                  hintStyle: TextStyle(
                    fontSize: EDIT_MESSAGE_TEXT_SIZE,
                    color: getColorFromHex("9AADDE"),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  static const EDIT_MESSAGE_HEIGHT = 56.0;
  static const EDIT_MESSAGE_CORNERS = 28.0;
  static const EDIT_MESSAGE_TEXT_SIZE = 18.0;
  static const EDIT_MESSAGE_PADDING_TEXT = 16.0;
  static const EDIT_MESSAGE_PADDING = 16.0;
  static const MESSAGE_CORNERS = 16.0;
  static const MESSAGE_TEXT_SIZE = 16.0;
  static const HORIZONTAL_PADDING_FROM_EDGE = 16.0;
  static const EXTRA_HORIZONTAL_PADDING = HORIZONTAL_PADDING_FROM_EDGE + 16.0;
  static const LIST_BOTTOM_PADDING = EDIT_MESSAGE_HEIGHT / 2 + 16.0;
  static const LIST_BOTTOM_CLIP_PADDING = EDIT_MESSAGE_HEIGHT / 2;
}
