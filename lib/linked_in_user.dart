// To parse this JSON data, do
//
//     final linkedinUser = linkedinUserFromMap(jsonString);

import 'dart:convert';

LinkedinUser linkedinUserFromMap(String str) =>
    LinkedinUser.fromMap(json.decode(str));

String linkedinUserToMap(LinkedinUser data) => json.encode(data.toMap());

class LinkedinUser {
  LinkedinUser({
    required this.localizedLastName,
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.localizedFirstName,
  });

  String localizedLastName;
  ProfilePicture profilePicture;
  StName firstName;
  StName lastName;
  String id;
  String localizedFirstName;

  LinkedinUser copyWith({
    String? localizedLastName,
    ProfilePicture? profilePicture,
    StName? firstName,
    StName? lastName,
    String? id,
    String? localizedFirstName,
  }) =>
      LinkedinUser(
        localizedLastName: localizedLastName ?? this.localizedLastName,
        profilePicture: profilePicture ?? this.profilePicture,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        id: id ?? this.id,
        localizedFirstName: localizedFirstName ?? this.localizedFirstName,
      );

  factory LinkedinUser.fromMap(Map<String, dynamic> json) => LinkedinUser(
        localizedLastName: json["localizedLastName"] == null
            ? null
            : json["localizedLastName"],
        profilePicture: json["profilePicture"] == null
            ? ProfilePicture.fromMap(json["profilePicture"])
            : ProfilePicture.fromMap(json["profilePicture"]),
        firstName: json["firstName"] == null
            ? StName.fromMap(json["firstName"])
            : StName.fromMap(json["firstName"]),
        lastName: json["lastName"] == null
            ? StName.fromMap(json["lastName"])
            : StName.fromMap(json["lastName"]),
        id: json["id"] == null ? null : json["id"],
        localizedFirstName: json["localizedFirstName"] == null
            ? null
            : json["localizedFirstName"],
      );

  Map<String, dynamic> toMap() => {
        "localizedLastName":
            localizedLastName == null ? null : localizedLastName,
        "profilePicture":
            profilePicture == null ? null : profilePicture.toMap(),
        "firstName": firstName == null ? null : firstName.toMap(),
        "lastName": lastName == null ? null : lastName.toMap(),
        "id": id == null ? null : id,
        "localizedFirstName":
            localizedFirstName == null ? null : localizedFirstName,
      };
}

class StName {
  StName({
    required this.localized,
    required this.preferredLocale,
  });

  Localized localized;
  PreferredLocale preferredLocale;

  StName copyWith({
    Localized? localized,
    PreferredLocale? preferredLocale,
  }) =>
      StName(
        localized: localized ?? this.localized,
        preferredLocale: preferredLocale ?? this.preferredLocale,
      );

  factory StName.fromMap(Map<String, dynamic> json) => StName(
        localized: json["localized"] == null
            ? Localized.fromMap(json["localized"])
            : Localized.fromMap(json["localized"]),
        preferredLocale: json["preferredLocale"] == null
            ? PreferredLocale.fromMap(json["preferredLocale"])
            : PreferredLocale.fromMap(json["preferredLocale"]),
      );

  Map<String, dynamic> toMap() => {
        "localized": localized == null ? null : localized.toMap(),
        "preferredLocale":
            preferredLocale == null ? null : preferredLocale.toMap(),
      };
}

class Localized {
  Localized({
    required this.enUs,
  });

  String enUs;

  Localized copyWith({
    String? enUs,
  }) =>
      Localized(
        enUs: enUs ?? this.enUs,
      );

  factory Localized.fromMap(Map<String, dynamic> json) => Localized(
        enUs: json["en_US"] == null ? null : json["en_US"],
      );

  Map<String, dynamic> toMap() => {
        "en_US": enUs == null ? null : enUs,
      };
}

class PreferredLocale {
  PreferredLocale({
    required this.country,
    required this.language,
  });

  String country;
  String language;

  PreferredLocale copyWith({
    String? country,
    String? language,
  }) =>
      PreferredLocale(
        country: country ?? this.country,
        language: language ?? this.language,
      );

  factory PreferredLocale.fromMap(Map<String, dynamic> json) => PreferredLocale(
        country: json["country"] == null ? null : json["country"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toMap() => {
        "country": country == null ? null : country,
        "language": language == null ? null : language,
      };
}

class ProfilePicture {
  ProfilePicture({
    required this.displayImage,
  });

  String displayImage;

  ProfilePicture copyWith({
    String? displayImage,
  }) =>
      ProfilePicture(
        displayImage: displayImage ?? this.displayImage,
      );

  factory ProfilePicture.fromMap(Map<String, dynamic> json) => ProfilePicture(
        displayImage:
            json["displayImage"] == null ? null : json["displayImage"],
      );

  Map<String, dynamic> toMap() => {
        "displayImage": displayImage == null ? null : displayImage,
      };
}
