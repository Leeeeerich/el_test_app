class ChatMessage {
  String ip;
  int requestTime;
  String text;

  ChatMessage();

  ChatMessage.text(this.text);

  ChatMessage.all(this.ip, this.requestTime, this.text);

  Map<String, dynamic> toJson() {
    return {'text': text};
  }

  factory ChatMessage.fromJson(Map<String, dynamic> map) {
    return ChatMessage.all(map['ip'], map['sendMoment'], map['text']);
  }
}
