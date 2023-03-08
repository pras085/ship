import 'package:azlogistik_chat/models/photo_file.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:azlogistik_chat/utilities/model_helper.dart';

part 'member.g.dart';

@JsonSerializable()
class Member{
  @JsonKey(fromJson: ModelHelper.intFromJson)
  int? IsSupplier, IsSupplierPublic, CityAreaID, CityID;
  
  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String? ID, Phone, Name, Email, Address, City, WebLink, AccessToken, BotKey, ReferralCode, FirstVideoLink, AddressResiOtomatis, Avatar;
  
  // Member2 Referrer;
  
  @JsonKey(fromJson: ModelHelper.dateTimeFromJson)
  DateTime? Created;
  
  PhotoFile? Photo;

  @JsonKey(fromJson: ModelHelper.boolFromJson)
  bool AccessRealPic, IsFavourite, DisableCOD, IsStar, HaveAccountValidation, IsResiOtomatis;
  @JsonKey(fromJson: ModelHelper.doubleFromJson)
  double ReferralCommission;
  @JsonKey(fromJson: ModelHelper.intFromJson)
  int ReferralCount, VoucherCount;

  // CompanyStats Stats;

  Member({
    this.Name,
    this.Phone,
    this.Email,
    this.Address,
    this.City,
    this.WebLink,
    this.AccessToken,
    this.BotKey,
    this.ReferralCode,
    this.FirstVideoLink,
    // this.Referrer,
    this.ID,
    this.IsSupplier,
    this.IsSupplierPublic,
    this.CityAreaID,
    this.CityID,
    this.Created,
    this.Photo,
    this.AccessRealPic = false,
    this.ReferralCommission = 0,
    this.ReferralCount = 0,
    this.VoucherCount = 0,
    this.IsFavourite = false,
    this.DisableCOD = false,
    this.IsStar = false,
    this.HaveAccountValidation = false,
    // this.Stats,
    this.IsResiOtomatis = false,
    this.AddressResiOtomatis,
    this.Avatar,
  });

  factory Member.fromJson(Map<String,dynamic> data) => _$MemberFromJson(data);

  Map<String,dynamic> toJson() => _$MemberToJson(this);
}
