enum WAKTU_BAHASA {
  WAKTU,
  BAHASA,
}

class ModelZonaWaktuDanBahasa {
  int id;
  String alias;
  String locale;
  String urlSegment;

  ModelZonaWaktuDanBahasa({this.id, this.alias});

  ModelZonaWaktuDanBahasa.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    alias = json['Alias'];
    locale = json['Locale'];
    urlSegment = json['URLSegment'];
  }
}

