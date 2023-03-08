import 'package:azlogistik_chat/utilities/model_helper.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cloud_file.g.dart';

@JsonSerializable()
class CloudFile{
  int? ID;
  
  @JsonKey(fromJson: ModelHelper.stringFromJson)
  String? URL;

  CloudFile({
    this.ID, 
    this.URL
  });

  factory CloudFile.fromJson(Map<String,dynamic> data) => _$CloudFileFromJson(data);

  Map<String,dynamic> toJson() => _$CloudFileToJson(this);
}