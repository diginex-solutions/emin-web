class Archive {
  String name;
  String uploadTime;
  String updateTime;
  String thirdPartyConsent;
  bool isChecked;

  Archive({this.name,
    this.uploadTime,
    this.updateTime,
    this.thirdPartyConsent,
    this.isChecked = false});
}
