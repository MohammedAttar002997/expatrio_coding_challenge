// To parse this JSON data, do
//
//     final userTaxModel = userTaxModelFromJson(jsonString);

import 'dart:convert';

UserTaxModel userTaxModelFromJson(String str) =>
    UserTaxModel.fromJson(json.decode(str));

String userTaxModelToJson(UserTaxModel data) => json.encode(data.toJson());

class UserTaxModel {
  PrimaryTaxResidence primaryTaxResidence;
  List<PrimaryTaxResidence> secondaryTaxResidence;

  UserTaxModel({
    required this.primaryTaxResidence,
    required this.secondaryTaxResidence,
  });

  factory UserTaxModel.fromJson(Map<String, dynamic> json) => UserTaxModel(
        primaryTaxResidence:
        PrimaryTaxResidence.fromJson(json["primaryTaxResidence"]),
        secondaryTaxResidence: List<PrimaryTaxResidence>.from(
            json["secondaryTaxResidence"]
                .map((x) => PrimaryTaxResidence.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "primaryTaxResidence": primaryTaxResidence.toJson(),
        "secondaryTaxResidence":
            List<dynamic>.from(secondaryTaxResidence.map((x) => x.toJson())),
      };
}

class PrimaryTaxResidence {
  String country;
  String id;

  PrimaryTaxResidence({
    required this.country,
    required this.id,
  });

  factory PrimaryTaxResidence.fromJson(Map<String, dynamic> json) =>
      PrimaryTaxResidence(
        country: json["country"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "id": id,
      };
}
