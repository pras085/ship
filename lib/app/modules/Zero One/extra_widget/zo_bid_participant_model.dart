class ZoBidParticipant {
  final int id;
  final int transporterId;
  final int truckOffer;
  final int initialPrice;
  final int finalPrice;
  final int fileId;
  final int qtyAccepted;
  final int status;
  final int numberOfNeeds;
  final int remainingNeeds;
  final String transporterName;
  final String transporterAvatar;
  final String created;
  final String pickedDate;
  final String transporterEmail;
  final String isGold;
  final String notes;
  final bool isRenego;
  final bool isNego;
  final bool isReview;
  final int star;

  ZoBidParticipant({
    this.id,
    this.transporterId,
    this.truckOffer,
    this.initialPrice,
    this.finalPrice,
    this.fileId,
    this.qtyAccepted,
    this.status,
    this.numberOfNeeds,
    this.remainingNeeds,
    this.transporterName,
    this.transporterAvatar,
    this.created,
    this.pickedDate,
    this.transporterEmail,
    this.isGold,
    this.isRenego,
    this.isNego,
    this.isReview,
    this.star,
    this.notes,
  });

  ZoBidParticipant copyWith({
    int id,
    int transporterId,
    int truckOffer,
    int initialPrice,
    int finalPrice,
    int fileId,
    int qtyAccepted,
    int status,
    int numberOfNeeds,
    int remainingNeeds,
    String transporterName,
    String transporterAvatar,
    String created,
    String pickedDate,
    String transporterEmail,
    String isGold,
    String notes,
    bool isRenego,
    bool isNego,
    bool isReview,
    int star,
  }) {
    return ZoBidParticipant(
      id: id ?? this.id,
      transporterId: transporterId ?? this.transporterId,
      truckOffer: truckOffer ?? this.truckOffer,
      initialPrice: initialPrice ?? this.initialPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      fileId: fileId ?? this.fileId,
      qtyAccepted: qtyAccepted ?? this.qtyAccepted,
      status: status ?? this.status,
      numberOfNeeds: numberOfNeeds ?? this.numberOfNeeds,
      remainingNeeds: remainingNeeds ?? this.remainingNeeds,
      transporterName: transporterName ?? this.transporterName,
      transporterAvatar: transporterAvatar ?? this.transporterAvatar,
      created: created ?? this.created,
      pickedDate: pickedDate ?? this.pickedDate,
      transporterEmail: transporterEmail ?? this.transporterEmail,
      isGold: isGold ?? this.isGold,
      isRenego: isRenego ?? this.isRenego,
      isNego: isNego ?? this.isNego,
      isReview: isReview ?? this.isReview,
      star: star ?? this.star,
      notes: notes ?? this.notes,
    );
  }

  factory ZoBidParticipant.fromJson(Map<String, dynamic> json) {
    // print("ZoBidParticipantJson" + json['transporterName']);
    return ZoBidParticipant(
      id: json['ID'],
      transporterId: json['transporterID'],
      truckOffer: json['truckOffer'],
      initialPrice: json['initialPrice'],
      finalPrice: json['finalPrice'],
      fileId: json['fileID'],
      qtyAccepted: json['qtyAccepted'],
      status: json['status'],
      numberOfNeeds: json['NumberOfNeeds'],
      remainingNeeds: json['RemainingNeeds'],
      // transporterName: json['transporterName'],
      transporterName: json['TransporterName'] ?? json['transporterName'],
      transporterAvatar: json['TransporterAvatar'] ?? json['transporterAvatar'],
      notes: "${json['notes']}",
      created: json['Created'],
      pickedDate: json['PickedDate'] ?? json['pickedDate'],
      transporterEmail: json['TransporterEmail'],
      isGold: json['IsGold'] ?? json['isGold'],
      // isGold: json['isGold'],
      isRenego: json['is_renego'],
      isNego: json['is_nego'],
      isReview: json['isReview'],
      star: json['star'] ?? json['transporterScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'transporterID': transporterId,
      'truckOffer': truckOffer,
      'initialPrice': initialPrice,
      'finalPrice': finalPrice,
      'fileID': fileId,
      'qtyAccepted': qtyAccepted,
      'status': status,
      'NumberOfNeeds': numberOfNeeds,
      'RemainingNeeds': remainingNeeds,
      'TransporterName': transporterName,
      'TransporterAvatar': transporterAvatar,
      'Created': created,
      'TransporterEmail': transporterEmail,
      'IsGold': isGold,
      'is_renego': isRenego,
      'is_rego': isNego,
    };
  }
}
