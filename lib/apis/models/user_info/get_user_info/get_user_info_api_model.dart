import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GetUserInfoApiModel extends Equatable {
  final int id;
  final String firstName;
  final String userImage;
  final String gender;
  final String marriageType;
  final String? userNotes;
  final String? userDescription;
  final String? nationality;
  final String? countryOfResidence;
  final String? city;
  final String? drinkingHabit;
  final String? smokingHabit;
  final String? exerciseFrequency;
  final List<String>? pets;
  final String? position;
  final RangeValues? income;
  final String? education;
  final String? islam;
  final String? perspective;
  final int? age;
  final double? weight;
  final double? height;
  final String? skinColor;
  final String? tribe;
  final bool? acceptNationality;
  final String? martialStatus;
  final String? kids;
  final String? look;
  final String? hair;
  final String? health;
  final bool? verified;
  final int? diamondCount;
  final bool? online;
  final int? messageCount;

  const GetUserInfoApiModel({
    required this.gender,
    required this.marriageType,
    required this.id,
    required this.firstName,
    required this.userImage,
    this.userNotes,
    this.userDescription,
    this.nationality,
    this.countryOfResidence,
    this.city,
    this.drinkingHabit,
    this.smokingHabit,
    this.exerciseFrequency,
    this.pets,
    this.position,
    this.income,
    this.education,
    this.islam,
    this.perspective,
    this.age,
    this.weight,
    this.height,
    this.skinColor,
    this.tribe,
    this.acceptNationality,
    this.martialStatus,
    this.kids,
    this.look,
    this.hair,
    this.health,
    this.verified,
    this.diamondCount,
    this.online,
    this.messageCount,
  });

  factory GetUserInfoApiModel.fromJson(Map<String, dynamic> json) {
    return GetUserInfoApiModel(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      marriageType: json['marriage_type'] as String,
      gender: json['gender'] as String,
      userNotes: json['user_notes'] as String,
      userDescription: json['user_description'] as String,
      nationality: json["nationality"],
      countryOfResidence: json["countryOfResidence"],
      city: json["city"],
      drinkingHabit: json["drinkingHabit"],
      smokingHabit: json["smokingHabit"],
      exerciseFrequency: json["exerciseFrequency"],
      pets: json["pets"],
      position: json["position"],
      income: json["income"],
      education: json["education"],
      islam: json["islam"],
      perspective: json["perspective"],
      age: json["age"],
      weight: json["weight"],
      height: json["height"],
      skinColor: json["skinColor"],
      tribe: json["tribe"],
      acceptNationality: json["acceptNationality"],
      martialStatus: json['martialStatus'],
      kids: json['kids'],
      look: json['look'],
      hair: json['hair'],
      health: json['health'],
      userImage: json['userImage'],
      verified: json['verified'],
      diamondCount: json['diamondCount'],
      online: json['online'],
      messageCount: json['messageCount'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    gender,
    marriageType,
    userDescription,
    userNotes,
    martialStatus,
    kids,
    look,
    hair,
    health,
    userImage,
    diamondCount,
    online,
    messageCount,
  ];
}
