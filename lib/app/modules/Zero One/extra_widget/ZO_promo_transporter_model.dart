import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:muatmuat/app/core/models/message_from_url_model.dart';

List tryAsList(dynamic value) => value == null
    ? null
    : value is List
        ? value
        : null;

String tryAsString(dynamic value) {
  return '$value'.trim().toLowerCase() == 'null' ? null : '$value';
}

extension _DateFormatExtension on DateFormat {
  DateTime tryParse(String inputString) {
    if (inputString == null) return null;
    try {
      return parse(inputString);
    } on FormatException {
      return null;
    }
  }
}

class ZoPromoTransporterResponseModel {
  final MessageFromUrlModel message;
  final List<ZoPromoTransporterDataModel> data;
  final int searchId;
  final ZoPromoTransporterSupportingDataModel supportingData;
  final int idSearchHistory;
  final int maxQty;
  final int minQty;
  final int maxHarga;
  final int minHarga;

  const ZoPromoTransporterResponseModel({
    this.message,
    this.data,
    this.searchId,
    this.supportingData,
    this.idSearchHistory,
    this.maxQty,
    this.minQty,
    this.maxHarga,
    this.minHarga,
  });

  factory ZoPromoTransporterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoPromoTransporterResponseModel(
      message: json['Message'] == null
          ? null
          : MessageFromUrlModel.fromJson(json['Message']),
      data: tryAsList(json['Data'])
          ?.map((e) => ZoPromoTransporterDataModel.fromJson(e))
          ?.toList(),
      searchId: int.tryParse('${json['searchID']}'),
      supportingData: ZoPromoTransporterSupportingDataModel.fromJson(
        json['SupportingData'],
      ),
      idSearchHistory: int.tryParse('${json['ID_Search_History']}'),
      maxQty: int.tryParse('${json['MaxQty']}'),
      minQty: int.tryParse('${json['MinQty']}'),
      maxHarga: int.tryParse('${json['MaxHarga']}'),
      minHarga: int.tryParse('${json['MinHarga']}'),
    );
  }
}

class ZoPromoTransporterSupportingDataModel {
  final int noLimitCount;
  final int limitCount;

  const ZoPromoTransporterSupportingDataModel({
    this.noLimitCount,
    this.limitCount,
  });

  factory ZoPromoTransporterSupportingDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;
    return ZoPromoTransporterSupportingDataModel(
      noLimitCount: int.tryParse('${json['NoLimitCount']}'),
      limitCount: int.tryParse('${json['LimitCount']}'),
    );
  }
}

class ZoPromoTransporterDataModel {
  final ZoPromoTransporterKeyModel key;
  final List<ZoPromoTransporterDetailModel> detail;
  final int biggestPrice;
  final int lowestPrice;
  final int biggestQty;
  final int lowestQty;
  final String biggestQuota;
  final String lowestQuota;
  final String biggestKapasitas;
  final String lowestKapasitas;
  final String headName;
  final String carrierName;

  const ZoPromoTransporterDataModel({
    this.key,
    this.detail,
    this.biggestPrice,
    this.lowestPrice,
    this.biggestQty,
    this.lowestQty,
    this.biggestQuota,
    this.lowestQuota,
    this.biggestKapasitas,
    this.lowestKapasitas,
    this.headName,
    this.carrierName,
  });

  factory ZoPromoTransporterDataModel.fromJson(Map<String, dynamic> json) {
    return ZoPromoTransporterDataModel(
      key: ZoPromoTransporterKeyModel.fromJson(json['key']),
      detail: tryAsList(json['detail'])
          ?.map((e) => ZoPromoTransporterDetailModel.fromJson(e))
          ?.toList(),
      biggestPrice: int.tryParse('${json['biggestPrice']}'),
      lowestPrice: int.tryParse('${json['lowestPrice']}'),
      biggestQty: int.tryParse('${json['biggestQty']}'),
      lowestQty: int.tryParse('${json['lowestQty']}'),
      biggestQuota: tryAsString('${json['biggestQuota']}'),
      lowestQuota: tryAsString('${json['lowestQuota']}'),
      biggestKapasitas: tryAsString('${json['biggestKapasitas']}'),
      lowestKapasitas: tryAsString('${json['lowestKapasitas']}'),
      headName: tryAsString('${json['headName']}'),
      carrierName: tryAsString('${json['carrierName']}'),
    );
  }
}

class ZoPromoTransporterDetailModel {
  final int id;
  final int fleetDataId;
  final String promoPrice;
  final String normalPrice;
  final int promoPriceInt;
  final int normalPriceInt;
  final String quotaRaw;
  final int quota;
  final int truckQty;
  final String headName;
  final String carrierName;
  final String truckPicture;
  final String minCapacityRaw;
  final String maxCapacityRaw;
  final double minCapacity;
  final double maxCapacity;
  final String capacityUnit;
  final int counterSeen;
  final String dimension;

  const ZoPromoTransporterDetailModel({
    this.id,
    this.fleetDataId,
    this.promoPriceInt,
    this.normalPriceInt,
    this.promoPrice,
    this.normalPrice,
    this.quotaRaw,
    this.quota,
    this.truckQty,
    this.headName,
    this.carrierName,
    this.truckPicture,
    this.minCapacityRaw,
    this.maxCapacityRaw,
    this.minCapacity,
    this.maxCapacity,
    this.capacityUnit,
    this.counterSeen,
    this.dimension,
  });

  factory ZoPromoTransporterDetailModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ZoPromoTransporterDetailModel(
      id: int.tryParse('${json['ID']}'),
      fleetDataId: int.tryParse('${json['fleet_data_id']}'),
      promoPrice: tryAsString(json['promo_price']),
      normalPrice: tryAsString(json['normal_price']),
      promoPriceInt: int.tryParse('${json['promo_price']}'.replaceAll('.', '')),
      normalPriceInt:
          int.tryParse('${json['normal_price']}'.replaceAll('.', '')),
      quotaRaw: tryAsString(json['quota']),
      quota: int.tryParse('${json['quota']}'.trim().replaceAll('.', '')),
      truckQty: int.tryParse('${json['truck_qty']}'),
      headName: tryAsString(json['head_name']),
      carrierName: tryAsString(json['carrier_name']),
      truckPicture: tryAsString(json['truck_picture']),
      minCapacityRaw: tryAsString(json['min_capacity']),
      maxCapacityRaw: tryAsString(json['max_capacity']),
      minCapacity: double.tryParse(
          '${json['min_capacity']}'.replaceAll('.', '').replaceAll(',', '.')),
      maxCapacity: double.tryParse(
          '${json['max_capacity']}'.replaceAll('.', '').replaceAll(',', '.')),
      capacityUnit: tryAsString(json['capacity_unit']),
      counterSeen: int.tryParse('${json['counter_seen']}'),
      dimension: tryAsString('${json['dimension']}'),
    );
  }

  String get title {
    StringBuffer titleStringBuffer = StringBuffer();
    var item = this;

    String formatThousand(int number) {
      if (number == null) return null;
      return "${NumberFormat('#,###').format(number).replaceAll(',', '.')}";
    }

    if (item?.quota != null) {
      titleStringBuffer.write('${formatThousand(item.quota)} ');
    } else {
      titleStringBuffer.write(item.quotaRaw == null ? '' : '${item.quotaRaw} ');
    }
    if (item?.headName?.isNotEmpty ?? false) {
      titleStringBuffer.write('${item.headName.trim()} ');
    }
    if (item?.carrierName?.isNotEmpty ?? false) {
      titleStringBuffer.write('- ${item.carrierName.trim()} ');
    }
    if (item?.minCapacity == null && (item?.minCapacityRaw?.isEmpty ?? true)) {
      titleStringBuffer.write('(? ~ ');
    } else {
      if (item?.minCapacity == null) {
        titleStringBuffer.write('(${item.minCapacityRaw.trim()} ~ ');
      } else {
        final minCapacityString = '${item.minCapacity}';
        if (minCapacityString.contains('.')) {
          var split = minCapacityString.split('.');
          var beforeComma = formatThousand(int.tryParse(split.first));
          var afterComma = split.last;
          var combined = '$beforeComma,$afterComma';

          if ((int.tryParse(combined.split(',').last) ?? -1) == 0) {
            titleStringBuffer.write('($beforeComma ~ ');
          } else {
            titleStringBuffer.write('($beforeComma,$afterComma ~ ');
          }
        } else {
          titleStringBuffer
              .write('(${formatThousand(item?.minCapacity?.toInt())} ~ ');
        }
      }
    }
    if (item?.maxCapacity == null && (item?.maxCapacityRaw?.isEmpty ?? true)) {
      titleStringBuffer.write('? ');
    } else {
      if (item?.minCapacity == null) {
        titleStringBuffer.write('${item.maxCapacityRaw.trim()} ');
      } else {
        final maxCapacityString = '${item.maxCapacity}';
        if (maxCapacityString.contains('.')) {
          var split = maxCapacityString.split('.');
          var beforeComma = formatThousand(int.tryParse(split.first));
          var afterComma = split.last;
          var combined = '$beforeComma,$afterComma';

          if ((int.tryParse(combined.split(',').last) ?? -1) == 0) {
            titleStringBuffer.write('$beforeComma ');
          } else {
            titleStringBuffer.write('$beforeComma,$afterComma ');
          }
        } else {
          titleStringBuffer
              .write('(${formatThousand(item?.maxCapacity?.toInt())} ');
        }
      }
    }
    if (item?.capacityUnit?.isEmpty ?? true) {
      titleStringBuffer.write('Ton)');
    } else {
      titleStringBuffer.write('${item.capacityUnit.trim()})');
    }

    return titleStringBuffer.toString();
  }
}

class ZoPromoTransporterKeyModel {
  final String fileName;
  final String link;
  final int id;
  final String TransporterEmail;
  final int TransporterID;
  final int TransporterName;
  final int status;
  final String createdRaw;
  final String created;
  final String createdTime;
  final DateTime createdDateTime;
  final String payment;
  final String notes;
  final String additionalNotes;
  final String capacityUnit;
  final int transporterId;
  final String transporterName;
  final String transporterAvatar;
  final String transporterEmail;
  final String transporterIsGold;
  final String destinationLocationName;
  final String destinationCity;
  final String destinationProvince;
  final String destinationKecamatan;
  final String destinationKecamatanPanjang;
  final String pickupLocationName;
  final String pickupCity;
  final String pickupProvince;
  final String pickupKecamatan;
  final String pickupKecamatanPanjang;
  final int transportPriceId;
  final String startDate;
  final String startDateRaw;
  final DateTime startDateTime;
  final String endDate;
  final String endDateRaw;
  final DateTime endDateTime;
  final int bigestPrice;
  final int lowestPrice;
  final String biggestQuota;
  final String lowestQuota;
  final String biggestKapasitas;
  final String lowestKapasitas;

  const ZoPromoTransporterKeyModel({
    this.fileName,
    this.link,
    this.id,
    this.TransporterEmail,
    this.TransporterID,
    this.TransporterName,
    this.status,
    this.createdRaw,
    this.created,
    this.createdTime,
    this.createdDateTime,
    this.payment,
    this.notes,
    this.additionalNotes,
    this.capacityUnit,
    this.transporterId,
    this.transporterName,
    this.transporterAvatar,
    this.transporterEmail,
    this.transporterIsGold,
    this.destinationLocationName,
    this.destinationCity,
    this.destinationProvince,
    this.destinationKecamatan,
    this.destinationKecamatanPanjang,
    this.pickupLocationName,
    this.pickupCity,
    this.pickupProvince,
    this.pickupKecamatan,
    this.pickupKecamatanPanjang,
    this.transportPriceId,
    this.startDate,
    this.startDateRaw,
    this.startDateTime,
    this.endDate,
    this.endDateRaw,
    this.endDateTime,
    this.bigestPrice,
    this.lowestPrice,
    this.biggestQuota,
    this.lowestQuota,
    this.biggestKapasitas,
    this.lowestKapasitas,
  });

  factory ZoPromoTransporterKeyModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final createdTimeString = tryAsString(json['CreatedTime'])?.trim();
    final createdTime = DateFormat('HH:mm').tryParse(createdTimeString);
    final createdDateString =
        (tryAsString(json['CreatedRaw']) ?? tryAsString(json['Created']))
            ?.trim();
    final createdDateTimeString =
        '$createdDateString${createdTime == null ? '' : ' $createdTimeString'}';

    final createdFormatter =
        DateFormat('yyyy-MM-dd${createdTime == null ? '' : ' HH:mm'}');

    final startRawString = tryAsString(json['start_date_raw'])?.trim();
    final startString = tryAsString(json['start_date'])?.trim();
    final endRawString = tryAsString(json['end_date_raw'])?.trim();
    final endString = tryAsString(json['end_date'])?.trim();
    final startDateTimeString = startRawString ?? startString;
    final endDateTimeString = endRawString ?? endString;

    final startFormatter = DateFormat(
      startRawString == null ? 'dd MMM yyyy' : 'yyyy-MM-dd',
      'en_US',
    );
    final endFormatter = DateFormat(
      endRawString == null ? 'dd MMM yyyy' : 'yyyy-MM-dd',
      'en_US',
    );

    return ZoPromoTransporterKeyModel(
      fileName: tryAsString(json['FileName']),
      link: tryAsString(json['Link']),
      id: int.tryParse('${json['ID']}'),
      TransporterEmail: tryAsString(json['TransporterEmail']),
      TransporterID: int.tryParse('${json['transporterID']}'),
      TransporterName: int.tryParse('${json['TransporterName']}'),
      status: int.tryParse('${json['status']}'),
      createdRaw: tryAsString(json['CreatedRaw']),
      created: tryAsString(json['Created']),
      createdTime: tryAsString(json['CreatedTime']),
      createdDateTime: createdFormatter.tryParse(createdDateTimeString),
      payment: tryAsString(json['payment']),
      notes: tryAsString(json['notes']),
      additionalNotes: tryAsString(json['additional_notes']),
      capacityUnit: tryAsString(json['capacity_unit']),
      transporterId: int.tryParse('${json['transporter_id']}'),
      transporterName: tryAsString(json['transporter_name']),
      transporterAvatar: tryAsString(json['transporter_avatar']),
      transporterEmail: tryAsString(json['transporter_email']),
      transporterIsGold: tryAsString(json['transporter_is_gold']),
      destinationLocationName: tryAsString(json['destination_location_name']),
      destinationCity: tryAsString(json['destination_city']),
      destinationProvince: tryAsString(json['destination_province']),
      destinationKecamatan: tryAsString(json['destination_kecamatan']),
      destinationKecamatanPanjang:
          tryAsString(json['destination_kecamatan_panjang']),
      pickupLocationName: tryAsString(json['pickup_location_name']),
      pickupCity: tryAsString(json['pickup_city']),
      pickupProvince: tryAsString(json['pickup_province']),
      pickupKecamatan: tryAsString(json['pickup_kecamatan']),
      pickupKecamatanPanjang: tryAsString(json['pickup_kecamatan_panjang']),
      transportPriceId: int.tryParse('${json['transport_price_id']}'),
      startDate: tryAsString(json['start_date']),
      startDateRaw: tryAsString(json['start_date_raw']),
      startDateTime: startFormatter.tryParse(startDateTimeString),
      endDate: tryAsString(json['end_date']),
      endDateRaw: tryAsString(json['end_date_raw']),
      endDateTime: endFormatter.tryParse(endDateTimeString),
      bigestPrice: int.tryParse('${json['bigest_price']}'),
      lowestPrice: int.tryParse('${json['lowest_price']}'),
      biggestQuota: tryAsString(json['biggest_quota']),
      lowestQuota: tryAsString(json['lowest_quota']),
      biggestKapasitas: tryAsString(json['biggest_kapasitas']),
      lowestKapasitas: tryAsString(json['lowest_kapasitas']),
    );
  }
}

class ZoPromoTransporterLatestSearchModel {
  final List<ZoPromoTransporterLatestSearchDataModel> data;

  const ZoPromoTransporterLatestSearchModel({this.data});

  factory ZoPromoTransporterLatestSearchModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;

    return ZoPromoTransporterLatestSearchModel(
      data: tryAsList(json['Data'])
          .map((e) => ZoPromoTransporterLatestSearchDataModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class ZoPromoTransporterLatestSearchDataModel {
  final String query;
  final DateTime createdAt;
  static const _format = 'yyyy-MM-dd HH:mm:ss';

  const ZoPromoTransporterLatestSearchDataModel({
    @required this.query,
    @required this.createdAt,
  });

  ZoPromoTransporterLatestSearchDataModel copyWith({
    String query,
    DateTime createdAt,
  }) {
    return ZoPromoTransporterLatestSearchDataModel(
      query: query ?? this.query,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory ZoPromoTransporterLatestSearchDataModel.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoPromoTransporterLatestSearchDataModel(
      query: '${json['query']}',
      createdAt: DateFormat(_format).tryParse('${json['created_at']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'created_at': DateFormat(_format).format(createdAt),
    };
  }
}
