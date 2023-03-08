class UploadModel {

  final bool isUpload;
  final int sent;
  final int total;
  final String errorMessage;

  UploadModel({
    this.isUpload = false,
    this.sent,
    this.total,
    this.errorMessage = "",
  });

  // UploadModel copyWith({
  //   bool isUpload,
  //   int sent,
  //   int total,
  //   String errorMessage,
  // }) {
  //   return UploadModel(
  //     isUpload: isUpload ?? this.isUpload,
  //     sent: sent ?? this.sent,
  //     total: total ?? this.total,
  //     errorMessage: errorMessage ?? this.errorMessage,
  //   );
  // }

}