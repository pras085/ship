// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      Name: ModelHelper.stringFromJson(json['Name']),
      Phone: ModelHelper.stringFromJson(json['Phone']),
      Email: ModelHelper.stringFromJson(json['Email']),
      Address: ModelHelper.stringFromJson(json['Address']),
      City: ModelHelper.stringFromJson(json['City']),
      WebLink: ModelHelper.stringFromJson(json['WebLink']),
      AccessToken: ModelHelper.stringFromJson(json['AccessToken']),
      BotKey: ModelHelper.stringFromJson(json['BotKey']),
      ReferralCode: ModelHelper.stringFromJson(json['ReferralCode']),
      FirstVideoLink: ModelHelper.stringFromJson(json['FirstVideoLink']),
      ID: ModelHelper.stringFromJson(json['ID']),
      IsSupplier: ModelHelper.intFromJson(json['IsSupplier']),
      IsSupplierPublic: ModelHelper.intFromJson(json['IsSupplierPublic']),
      CityAreaID: ModelHelper.intFromJson(json['CityAreaID']),
      CityID: ModelHelper.intFromJson(json['CityID']),
      Created: ModelHelper.dateTimeFromJson(json['Created']),
      Photo: json['Photo'] == null
          ? null
          : PhotoFile.fromJson(json['Photo'] as Map<String, dynamic>),
      AccessRealPic: json['AccessRealPic'] == null
          ? false
          : ModelHelper.boolFromJson(json['AccessRealPic']),
      ReferralCommission: json['ReferralCommission'] == null
          ? 0
          : ModelHelper.doubleFromJson(json['ReferralCommission']),
      ReferralCount: json['ReferralCount'] == null
          ? 0
          : ModelHelper.intFromJson(json['ReferralCount']),
      VoucherCount: json['VoucherCount'] == null
          ? 0
          : ModelHelper.intFromJson(json['VoucherCount']),
      IsFavourite: json['IsFavourite'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsFavourite']),
      DisableCOD: json['DisableCOD'] == null
          ? false
          : ModelHelper.boolFromJson(json['DisableCOD']),
      IsStar: json['IsStar'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsStar']),
      HaveAccountValidation: json['HaveAccountValidation'] == null
          ? false
          : ModelHelper.boolFromJson(json['HaveAccountValidation']),
      IsResiOtomatis: json['IsResiOtomatis'] == null
          ? false
          : ModelHelper.boolFromJson(json['IsResiOtomatis']),
      AddressResiOtomatis:
          ModelHelper.stringFromJson(json['AddressResiOtomatis']),
      Avatar: ModelHelper.stringFromJson(json['Avatar']),
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'IsSupplier': instance.IsSupplier,
      'IsSupplierPublic': instance.IsSupplierPublic,
      'CityAreaID': instance.CityAreaID,
      'CityID': instance.CityID,
      'ID': instance.ID,
      'Phone': instance.Phone,
      'Name': instance.Name,
      'Email': instance.Email,
      'Address': instance.Address,
      'City': instance.City,
      'WebLink': instance.WebLink,
      'AccessToken': instance.AccessToken,
      'BotKey': instance.BotKey,
      'ReferralCode': instance.ReferralCode,
      'FirstVideoLink': instance.FirstVideoLink,
      'AddressResiOtomatis': instance.AddressResiOtomatis,
      'Avatar': instance.Avatar,
      'Created': instance.Created?.toIso8601String(),
      'Photo': instance.Photo,
      'AccessRealPic': instance.AccessRealPic,
      'IsFavourite': instance.IsFavourite,
      'DisableCOD': instance.DisableCOD,
      'IsStar': instance.IsStar,
      'HaveAccountValidation': instance.HaveAccountValidation,
      'IsResiOtomatis': instance.IsResiOtomatis,
      'ReferralCommission': instance.ReferralCommission,
      'ReferralCount': instance.ReferralCount,
      'VoucherCount': instance.VoucherCount,
    };
