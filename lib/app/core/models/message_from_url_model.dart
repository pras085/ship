class MessageFromUrlModel {
  int code;
  String text;

  MessageFromUrlModel({this.code, this.text});

  MessageFromUrlModel.fromJson(Map<String, dynamic> json){
    code = json['Code'];
    text = json['Text'];
  }
}