class ModelSyaratProfil {
  String title;
  String type;
  String contentId;
  String lastEdited;

  ModelSyaratProfil({this.title, this.type, this.contentId});

  ModelSyaratProfil.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    type = json['type'];
    contentId = json['content_id'];
    lastEdited = json['LastEdited'];
  }
}