import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nasebak_app/apis/models/home/home_api_model.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

class HomeUiModel extends Equatable {
  final UserInfoUiModel userInfo;
  final UserInfoUiModel otherUserInfo;

  const HomeUiModel({required this.userInfo, required this.otherUserInfo});

  factory HomeUiModel.fromApi(HomeApiModel e) {
    return HomeUiModel(
      userInfo: UserInfoUiModel.fromApi(e.userInfo),
      otherUserInfo: UserInfoUiModel.fromApi(e.otherUserInfo),
    );
  }

  factory HomeUiModel.dummy() {
    return HomeUiModel(
      userInfo: UserInfoUiModel(
        id: 1,
        firstName: "فهد",
        gender: "Male",
        marriageType: "أعزب",
        age: 30,
        nationality: "تونس",
        countryOfResidence: "تونس",
        city: "تونس",
        education: "Bachelor's Degree",
        income: RangeValues(0, 5000),
        smokingHabit: "No",
        drinkingHabit: "Occasionally",
        exerciseFrequency: "Daily",
        pets: ["Dog"],
        skinColor: "Fair",
        tribe: "None",
        acceptNationality: true,
        martialStatus: "أعزب",
        kids: "None",
        look: "Attractive",
        hair: "Brown",
        health: "Good",
        position: "حكومي",
        description:
            " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        verified: true,
      ),
      otherUserInfo: UserInfoUiModel(
        id: 2,
        firstName: "عبد الله",
        gender: "Female",
        marriageType: "اعزب",
        age: 28,
        nationality: "السعودية",
        countryOfResidence: "السعودية",
        city: "السعودية",
        education: "Master's Degree",
        income: RangeValues(0, 6000),
        smokingHabit: "No",
        drinkingHabit: "Never",
        exerciseFrequency: "Weekly",
        pets: ["Cat"],
        skinColor: "أسمر",
        tribe: "None",
        acceptNationality: false,
        martialStatus: "اعزب",
        kids: "None",
        look: "Charming",
        hair: "Black",
        health: "Excellent",
        diamondCount: 3,
        online: true,
        height: 180.5,
        weight: 100,
        position: "حكومي",
        messageCount: 140,
      ),
    );
  }

  @override
  List<Object?> get props => [userInfo, otherUserInfo];
}
