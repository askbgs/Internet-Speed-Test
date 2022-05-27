class Datamodel {
  int? id;
  String isp;
  String mode;
  String downloadSpeed;
  String uploadSpeed;
  String createddate;
  String updateddate;
  int isChecked;

  Datamodel({
    this.id,
    required this.isp,
    required this.mode,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.createddate,
    required this.updateddate,
    required this.isChecked,
  });

  factory Datamodel.fromJson(Map<String, dynamic> data) => Datamodel(
      id: data["id"],
      isp: data["isp"],
      mode: data["mode"],
      downloadSpeed: data["downloadSpeed"].toString(),
      uploadSpeed: data["uploadSpeed"].toString(),
      createddate: data["createddate"],
      updateddate: data["updateddate"],
      isChecked: data["isChecked"]);

  Map<String, dynamic> toJson() => {
        "isp": isp,
        "mode": mode,
        "downloadSpeed": downloadSpeed,
        "uploadSpeed": uploadSpeed,
        "createddate": createddate,
        "updateddate": updateddate,
        "isChecked": isChecked
      };
}
