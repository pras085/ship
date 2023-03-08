class TMCheckSegmentedUserModel {
  int isSegmented;
  int type;
  int capacity;
  int isVerif;
  int countPacketBF;
  int countPacketTambah;
  int countPacket;
  int isFirst;

  TMCheckSegmentedUserModel();

  TMCheckSegmentedUserModel.fromJson(Map<String, dynamic> json) {
    isSegmented = json['IsSegmented'];
    type = json['Type'];
    capacity = json['Capacity'];
    isVerif = json['IsVerif'];
    countPacketBF = json['CountPacketBF'];
    countPacketTambah = json['CountPacketTambah'];
    countPacket = json['CountPacket'];
    isFirst = json['IsFirst'];
  }
}
