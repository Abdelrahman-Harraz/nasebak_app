import 'package:flutter/material.dart';
import 'package:nasebak_app/apis/models/user_info/get_user_info/get_user_info_api_model.dart';

class UserInfoUiModel {
  final int id;
  String? firstName;
  final String gender;
  final String marriageType;
  final String? conditions;
  final String? description;
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
  final double? age;
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

  UserInfoUiModel({
    required this.gender,
    required this.marriageType,
    required this.id,
    this.conditions,
    this.description,
    this.firstName,
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
  });

  factory UserInfoUiModel.fromApi(GetUserInfoApiModel e) {
    return UserInfoUiModel(
      id: e.id,
      firstName: e.firstName,
      gender: e.gender,
      marriageType: e.marriageType,
      conditions: e.userNotes,
      description: e.userDescription,
      nationality: e.nationality,
      countryOfResidence: e.countryOfResidence,
      city: e.city,
      drinkingHabit: e.drinkingHabit,
      smokingHabit: e.smokingHabit,
      exerciseFrequency: e.exerciseFrequency,
      pets: e.pets,
      position: e.position,
      income: e.income,
      education: e.education,
      islam: e.islam,
      perspective: e.perspective,
      age: e.age,
      weight: e.weight,
      height: e.height,
      skinColor: e.skinColor,
      tribe: e.tribe,
      acceptNationality: e.acceptNationality,
    );
  }
}
