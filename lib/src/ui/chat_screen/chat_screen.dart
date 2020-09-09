import 'package:el_test_app/src/ui/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key key}) : super(key: key);

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getColorFromHex("E5E5E5"),
        appBar: AppBar(
          title: Row(children: <Widget>[
            Image.asset("assets/icons/ic_elomia.png",
                fit: BoxFit.cover, height: 46),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Text(FlutterI18n.translate(context, "elomia_title"))),
          ]),
          backgroundColor: getColorFromHex("A4B3EA"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [],
              )),
              _inputMessage(),
            ],
          ),
        ));
  }

  Widget _inputMessage() {
    return Container(
      // padding: EdgeInsets.fromLTRB(18, 13, 18, 13),
      alignment: Alignment.bottomCenter,
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/ic_send.svg",
                  semanticsLabel:
                      FlutterI18n.translate(context, "send_message"),
                ),
                onPressed: () {
                  print("Send");
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
