import 'dart:convert';

LogoutData logoutDataFromJson(String str) =>
    LogoutData.fromJson(json.decode(str));

String logoutDataToJson(LogoutData data) => json.encode(data.toJson());

class LogoutData {
  LogoutData({
    required this.logoutMessage,
    required this.btnYes,
    required this.btnNo,
  });

  String logoutMessage;
  String btnYes;
  String btnNo;

  factory LogoutData.fromJson(Map<String, dynamic> json) => LogoutData(
        logoutMessage: json["logout_message"],
        btnYes: json["btn_yes"],
        btnNo: json["btn_no"],
      );

  Map<String, dynamic> toJson() => {
        "logout_message": logoutMessage,
        "btn_yes": btnYes,
        "btn_no": btnNo,
      };
}
