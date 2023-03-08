class LanguageData {
  String name;
  String pageLink;
  String words;
  String type;
  String language;
  int version;
  LanguageData(
      {this.name,
      this.pageLink,
      this.words,
      this.type,
      this.language,
      this.version});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pageLink': pageLink,
      'words': words,
      'class': type,
      'language': language,
      'version': version
    };
  }
}

class ListLanguageData {
  String title;
  String locale;
  String urlSegment;
  ListLanguageData({this.title, this.locale, this.urlSegment});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'locale': locale,
      'URLSegment': urlSegment,
    };
  }
}
