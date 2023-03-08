import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_annotation/json_annotation.dart';
part 'photo_file.g.dart';

@JsonSerializable()
class PhotoFile{
  @JsonKey(fromJson: ModelHelper.intFromJson)
  int ID;

  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String? Original, Small, Medium;

  PhotoFile({
    this.ID = 0,
    this.Original,
    this.Small,
    this.Medium,
  });

  factory PhotoFile.fromJson(Map<String,dynamic> data) => _$PhotoFileFromJson(data);

  Map<String,dynamic> toJson() => _$PhotoFileToJson(this);

  bool isImage() {
    var exts = ['jpg','jpeg','png','bmp','gif'];
    var arr = Original?.split('.');
    if(arr != null){
      return exts.contains(arr.last.toLowerCase());
    }
    return false;
  }

  String getFileName(){
    var arr = Original?.split('/');
    if(arr != null){
      return arr.last;
    }
    return '';
  }

  Widget icon({
    double? size,
    Color? color,
  }){
    var assetName = '';
    var arr = Original?.split('.');
    var ext = arr?.last.toLowerCase() ?? '';
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        assetName = 'jpg-icon.svg';
        break;
      case 'png':
        assetName = 'png-icon.svg';
        break;
      case 'doc':
      case 'docx':
        assetName = 'doc-icon.svg';
        break;
      case 'xls':
      case 'xlsx':
        assetName = 'xls-icon.svg';
        break;
      case 'pdf':
        assetName = 'pdf-icon.svg';
        break;
      case 'zip':
        assetName = 'zip-icon.svg';
        break;
      case 'mp4':
      case 'mov':
      case 'avi':
        assetName = 'movie-icon.svg';
        break;
      default:
    }
    if(assetName != ''){
      return SvgPicture.asset(
        'assets/images/' + assetName,
        package: 'azlogistik_chat',
        width: size ?? 24,
        height: size ?? 24,
      );
    }
    else{
      return Icon(
        Icons.article,
        color: color ?? AColors.primary,
        size: size ?? 16,
      );
    }
  }
}