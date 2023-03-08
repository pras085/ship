class ProfileShipperMenuModel {
  final String title;
  final String urlIcon;
  bool isEnabled;
  void Function() onTap;

  ProfileShipperMenuModel(this.title, this.urlIcon,
      {this.isEnabled = true, this.onTap});
}
