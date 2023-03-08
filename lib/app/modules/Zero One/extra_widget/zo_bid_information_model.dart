class ZoBidInformation {
  final int id;
  final String createdRaw;
  final String created;
  final String bidNo;
  final String startDate;
  final String endDate;
  final String bidType;
  final int truckQty;
  final String headName;
  final String carrierName;
  final int truckId;
  final String cargo;
  final String idCargoType;
  final String volume;
  final String dimension;
  final int koliQty;
  final String pickupType;
  final String pickupEta;
  final String pickupEtaTimezone;
  final String destinationType;
  final String destinationEta;
  final String destinationEtaTimezone;
  final int maxPrice;
  final Object priceInclude;
  final int itemPrice;
  final Object handlingLoadingPrice;
  final Object handlingUnloadingPrice;
  final String paymentTerm;
  final int status;
  final Object dateBidClosed;
  final int viewers;
  final String notes;
  final int remainingNeeds;
  final String shipperName;
  final String cityPickup;
  final String cityDestination;

  ZoBidInformation({
    this.id,
    this.createdRaw,
    this.created,
    this.bidNo,
    this.startDate,
    this.endDate,
    this.bidType,
    this.truckQty,
    this.headName,
    this.carrierName,
    this.truckId,
    this.cargo,
    this.idCargoType,
    this.volume,
    this.dimension,
    this.koliQty,
    this.pickupType,
    this.pickupEta,
    this.pickupEtaTimezone,
    this.destinationType,
    this.destinationEta,
    this.destinationEtaTimezone,
    this.maxPrice,
    this.priceInclude,
    this.itemPrice,
    this.handlingLoadingPrice,
    this.handlingUnloadingPrice,
    this.paymentTerm,
    this.status,
    this.dateBidClosed,
    this.viewers,
    this.notes,
    this.remainingNeeds,
    this.shipperName,
    this.cityPickup,
    this.cityDestination,
  });

  factory ZoBidInformation.fromJson(Map<String, dynamic> json) {
    print("BidItemJson" + json.toString());
    return ZoBidInformation(
      id: json['ID'],
      createdRaw: json['CreatedRaw'] ?? "",
      created: json['Created'] ?? "",
      bidNo: json['BidNo'] ?? "",
      startDate: json['StartDate'] ?? "",
      endDate: json['EndDate'] ?? "",
      bidType: json['BidType'] ?? "",
      truckQty: json['TruckQty'],
      headName: json['HeadName'] ?? "",
      carrierName: json['CarrierName'] ?? "",
      truckId: json['TruckId'],
      cargo: json['Cargo'] ?? "",
      idCargoType: json['IdCargoType'] ?? "",
      volume: json['Volume'] ?? "",
      dimension: json['Dimension'] ?? "",
      koliQty: json['KoliQty'],
      pickupType: json['PickupType'] ?? "",
      pickupEta: json['PickupEta'] ?? "",
      pickupEtaTimezone: json['PickupEtaTimezone'] ?? "",
      destinationType: json['DestinationType'] ?? "",
      destinationEta: json['DestinationEta'] ?? "",
      destinationEtaTimezone: json['DestinationEtaTimezone'] ?? "",
      maxPrice: json['MaxPrice'],
      priceInclude: json['PriceInclude'] ?? "",
      itemPrice: json['ItemPrice'],
      handlingLoadingPrice: json['HandlingLoadingPrice'] ?? "",
      handlingUnloadingPrice: json['HandlingUnloadingPrice'] ?? "",
      paymentTerm: json['PaymentTerm'] ?? "",
      status: json['Status'],
      dateBidClosed: json['DateBidClosed'] ?? "",
      viewers: json['Viewers'],
      notes: json['Notes'] ?? "",
      remainingNeeds: json['RemainingNeeds'],
      shipperName: json['ShipperName'] ?? "",
      cityPickup: json['CityPickup'] ?? "",
      cityDestination: json['CityDestination'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CreatedRaw': createdRaw,
      'Created': created,
      'BidNo': bidNo,
      'StartDate': startDate,
      'EndDate': endDate,
      'BidType': bidType,
      'TruckQty': truckQty,
      'HeadName': headName,
      'CarrierName': carrierName,
      'TruckId': truckId,
      'Cargo': cargo,
      'IdCargoType': idCargoType,
      'Volume': volume,
      'Dimension': dimension,
      'KoliQty': koliQty,
      'PickupType': pickupType,
      'PickupEta': pickupEta,
      'PickupEtaTimezone': pickupEtaTimezone,
      'DestinationType': destinationType,
      'DestinationEta': destinationEta,
      'DestinationEtaTimezone': destinationEtaTimezone,
      'MaxPrice': maxPrice,
      'PriceInclude': priceInclude,
      'ItemPrice': itemPrice,
      'HandlingLoadingPrice': handlingLoadingPrice,
      'HandlingUnloadingPrice': handlingUnloadingPrice,
      'PaymentTerm': paymentTerm,
      'Status': status,
      'DateBidClosed': dateBidClosed,
      'Viewers': viewers,
      'Notes': notes,
      'RemainingNeeds': remainingNeeds,
      'ShipperName': shipperName,
      'CityPickup': cityPickup,
      'CityDestination': cityDestination,
    };
  }
}
