// To parse this JSON data, do
//
//     final listProfileResponseModel = listProfileResponseModelFromJson(jsonString);

import 'dart:convert';



class Data {
  Data({
    required this.getAllProfiles,
  });

  List<GetAllProfile> getAllProfiles;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        getAllProfiles:
            List<GetAllProfile>.from(json["getAllProfiles"].map((x) => GetAllProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "getAllProfiles": List<dynamic>.from(getAllProfiles.map((x) => x.toJson())),
      };
}

class GetAllProfile {
  GetAllProfile({
    this.id,
    this.bio,
    this.country,
    this.dob,
    this.gender,
    this.lat,
    this.lng,
    this.name,
    this.optinMarketing,
    this.photos,
  });

  String? id;
  String? bio;
  String? country;
  DateTime? dob;
  Gender? gender;
  double? lat;
  double? lng;
  String? name;
  bool? optinMarketing;
  List<Photo>? photos;

  factory GetAllProfile.fromJson(Map<String, dynamic> json) => GetAllProfile(
        id: json["id"],
        bio: json["bio"] == null ? null : json["bio"],
        country: json["country"] == null ? null : json["country"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        gender: json["gender"] == null ? null : genderValues.map![json["gender"]],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        name: json["name"] == null ? null : json["name"],
        optinMarketing: json["optin_marketing"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bio": bio == null ? null : bio,
        "country": country == null ? null : country,
        "dob": dob == null ? null : dob?.toIso8601String(),
        "gender": gender == null ? null : genderValues.reverse[gender],
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "name": name == null ? null : name,
        "optin_marketing": optinMarketing,
        "photos": photos == null ? null : List<dynamic>.from(photos!.map((x) => x.toJson())),
      };
}

enum Gender { FEMALE, MALE }

final genderValues = EnumValues({"FEMALE": Gender.FEMALE, "MALE": Gender.MALE});

class Photo {
  Photo({
    this.id,
    this.url,
    this.type,
  });

  String? id;
  String? url;
  String? type;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        url: json["url"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type == null ? null : type,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
