class ChatMessage  {
  String ip;
  DateTime sendMoment;
  String text;

  ChatMessage(this.ip, this.sendMoment, this.text);

  Map<String, dynamic> toJson() {
    return {'text': text};
  }

  factory ChatMessage.fromJson(Map<String, dynamic> map) {
    return ChatMessage(map['ip'], map['sendMoment']?.toDate(), map['text']);
  }
}
