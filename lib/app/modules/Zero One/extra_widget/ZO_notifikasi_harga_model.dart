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

class ZoDeleteNotifikasiHargaResponseModel {
  final MessageFromUrlModel message;
  final int status;

  const ZoDeleteNotifikasiHargaResponseModel({
    this.message,
    this.status,
  });

  factory ZoDeleteNotifikasiHargaResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;
    return ZoDeleteNotifikasiHargaResponseModel(
      message: json['Message'] == null
          ? null
          : MessageFromUrlModel.fromJson(json['Message']),
      status: int.tryParse('${json['Status']}'.trim()),
    );
  }
}

class ZoCreateUpdateNotifikasiHargaResponseModel {
  final MessageFromUrlModel message;
  final ZoCreateUpdateNotifikasiHargaDataModel data;

  const ZoCreateUpdateNotifikasiHargaResponseModel({
    this.message,
    this.data,
  });

  factory ZoCreateUpdateNotifikasiHargaResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;
    return ZoCreateUpdateNotifikasiHargaResponseModel(
      message: json['Message'] == null
          ? null
          : MessageFromUrlModel.fromJson(json['Message']),
      data: ZoCreateUpdateNotifikasiHargaDataModel.fromJson(json['Data']),
    );
  }
}

class ZoCreateUpdateNotifikasiHargaDataModel {
  final int id;

  const ZoCreateUpdateNotifikasiHargaDataModel({this.id});

  factory ZoCreateUpdateNotifikasiHargaDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;

    return ZoCreateUpdateNotifikasiHargaDataModel(
      id: int.tryParse('${json['ID']}'.trim()),
    );
  }
}

class ZoNotifikasiHargaResponseModel {
  final MessageFromUrlModel message;
  final List<ZoNotifikasiHargaModel> data;
  final String size;

  const ZoNotifikasiHargaResponseModel({this.message, this.data, this.size});

  factory ZoNotifikasiHargaResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ZoNotifikasiHargaResponseModel(
      message: json['Message'] == null
          ? null
          : MessageFromUrlModel.fromJson(json['Message']),
      data: tryAsList(json['Data'])
          ?.map((e) => ZoNotifikasiHargaModel.fromJson(e))
          ?.toList(),
      size: tryAsString(json['size'])?.trim(),
    );
  }
}

class ZoNotifikasiHargaModel {
  final int id;
  final String pickup;
  final String destination;
  final String transporterName;
  final String headName;
  final String carrierName;
  final String notificationType;
  final String createdDateRaw;
  final String createdTimeRaw;
  final int transporterId;
  final int minPrice;
  final int maxPrice;
  final String createdAtRaw;
  final DateTime created;

  const ZoNotifikasiHargaModel({
    this.id,
    this.pickup,
    this.destination,
    this.transporterName,
    this.headName,
    this.carrierName,
    this.notificationType,
    this.createdDateRaw,
    this.createdTimeRaw,
    this.transporterId,
    this.minPrice,
    this.maxPrice,
    this.createdAtRaw,
    this.created,
  });

  factory ZoNotifikasiHargaModel.fromParameters(Map<String, String> params) {
    if (params == null) return null;
    return ZoNotifikasiHargaModel(
      id: int.tryParse('${params['ID']}'.trim()),
      pickup: '${params['pickup_location']}',
      destination: '${params['destination_location']}',
      transporterName: '${params['transporter_name']}',
      headName: '${params['head_name']}',
      carrierName: '${params['carrier_name']}',
      notificationType: '${params['notification_type']}',
      transporterId: int.tryParse('${params['transporter_id']}'.trim()),
      minPrice: int.tryParse('${params['harga_min']}'.trim()),
      maxPrice: int.tryParse('${params['harga_max']}'.trim()),
    );
  }

  Map<String, String> toParams() {
    return <String, String>{
      'ID': '$id',
      'pickup_location': '$pickup',
      'destination_location': '$destination',
      'transporter_name': '$transporterName',
      'head_name': '$headName',
      'carrier_name': '$carrierName',
      'notification_type': '$notificationType',
      'transporter_id': '$transporterId',
      'harga_min': '$minPrice',
      'harga_max': '$maxPrice',
    };
  }

  factory ZoNotifikasiHargaModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final createdTimeString = tryAsString(json['CreatedTime'])?.trim();
    final createdTime = DateFormat('HH:mm').tryParse(createdTimeString);
    final createdDateString = tryAsString(json['Created'])?.trim();
    final createdDateTimeString =
        '$createdDateString${createdTime == null ? '' : ' $createdTimeString'}';
    final createdFormatter =
        DateFormat('yyyy-MM-dd${createdTime == null ? '' : ' HH:mm'}');

    final dateTime = createdFormatter.tryParse(createdDateTimeString);

    return ZoNotifikasiHargaModel(
      id: int.tryParse('${json['ID']}'.trim()),
      pickup: '${json['pickup_location']}',
      destination: '${json['destination_location']}',
      transporterName: '${json['transporter_name']}',
      headName: '${json['head_name']}',
      carrierName: '${json['carrier_name']}',
      notificationType: '${json['notification_type']}',
      createdDateRaw: '${json['Created']}',
      createdTimeRaw: '${json['CreatedTime']}',
      transporterId: int.tryParse('${json['transporter_id']}'.trim()),
      minPrice: int.tryParse('${json['harga_min']}'.trim()),
      maxPrice: int.tryParse('${json['harga_max']}'.trim()),
      createdAtRaw: '${json['created_at']}',
      created: dateTime,
    );
  }
}

class ZoRegionByCityResponseModel {
  final MessageFromUrlModel message;
  final List<ZoRegionByCityModel> data;
  final String type;

  const ZoRegionByCityResponseModel({
    this.message,
    this.data,
    this.type,
  });

  factory ZoRegionByCityResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoRegionByCityResponseModel(
      message: MessageFromUrlModel.fromJson(json['Message']),
      data: json['Data'] is List
          ? (json['Data'] as List)
              .map((datumJson) => ZoRegionByCityModel.fromJson(datumJson))
              .toList()
          : null,
      type: '${json['Type']}',
    );
  }
}

class ZoRegionByCityModel {
  final int provinceId;
  final String province;
  final int cityId;
  final String city;
  final String modifiedCity;
  final String description;

  const ZoRegionByCityModel({
    this.provinceId,
    this.province,
    this.cityId,
    this.city,
    this.modifiedCity,
    this.description,
  });

  factory ZoRegionByCityModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoRegionByCityModel(
      provinceId: int.tryParse('${json['ProvinceID']}'.trim()),
      province: tryAsString('${json['Province']}'),
      cityId: int.tryParse('${json['CityID']}'.trim()),
      city: tryAsString('${json['City']}'),
      modifiedCity: tryAsString('${json['ModifiedCity']}'),
      description: tryAsString('${json['Description']}'),
    );
  }
}

class ZoTransporterFreeSupportingDataModel {
  final int realCountData;
  final int countData;

  const ZoTransporterFreeSupportingDataModel({
    this.realCountData,
    this.countData,
  });

  factory ZoTransporterFreeSupportingDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json == null) return null;
    return ZoTransporterFreeSupportingDataModel(
      countData: int.tryParse('${json['CountData']}'),
      realCountData: int.tryParse('${json['RealCountData']}'),
    );
  }
}

class ZoTransporterFreeResponseModel {
  final MessageFromUrlModel message;
  final List<ZoTransporterFreeModel> data;
  final String type;
  final ZoTransporterFreeSupportingDataModel supportingData;

  const ZoTransporterFreeResponseModel({
    this.message,
    this.data,
    this.type,
    this.supportingData,
  });

  factory ZoTransporterFreeResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoTransporterFreeResponseModel(
      message: MessageFromUrlModel.fromJson(json['Message']),
      data: json['Data'] is List
          ? (json['Data'] as List)
              .map((datumJson) => ZoTransporterFreeModel.fromJson(datumJson))
              .toList()
          : null,
      supportingData:
          ZoTransporterFreeSupportingDataModel.fromJson(json['SupportingData']),
      type: '${json['Type']}',
    );
  }
}

class ZoTransporterFreeModel {
  final int transporterId;
  final String avatar;
  final String name;

  const ZoTransporterFreeModel({
    this.transporterId,
    this.avatar,
    this.name,
  });

  factory ZoTransporterFreeModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ZoTransporterFreeModel(
      transporterId: int.tryParse('${json['TransporterID']}'),
      avatar: '${json['Avatar']}',
      name: '${json['Name']}',
    );
  }
}
