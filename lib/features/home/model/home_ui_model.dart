import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nasebak_app/apis/models/home/home_api_model.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

class HomeUiModel extends Equatable {
  final UserInfoUiModel userInfo;
  final List<UserInfoUiModel> otherUserInfo;

  const HomeUiModel({required this.userInfo, required this.otherUserInfo});

  factory HomeUiModel.fromApi(HomeApiModel e) {
    return HomeUiModel(
      userInfo: UserInfoUiModel.fromApi(e.userInfo),
      otherUserInfo:
          e.otherUserInfo
              .map((userInfo) => UserInfoUiModel.fromApi(userInfo))
              .toList(),
    );
  }

  factory HomeUiModel.dummy() {
    return HomeUiModel(
      userInfo: UserInfoUiModel(
        id: 1,
        firstName: "فهد",
        gender: "Male",
        marriageType: "زواج تقليدي",
        weight: 50,
        age: 30,
        nationality: "تونس",
        countryOfResidence: "تونس",
        city: "تونس",
        education: "الدبلوم",
        income: RangeValues(0, 5000),
        smokingHabit: "أحاول تركه",
        drinkingHabit: "لا أشرب",
        exerciseFrequency: "كل يوم",
        pets: ["Dog"],
        skinColor: "بياض شامي",
        tribe: "",
        acceptNationality: true,
        martialStatus: "أعزب",
        kids: "مع والدتهم",
        look: "وسيم",
        hair: "ناعم",
        health: "سليمـ / ـة",
        position: "حكومي",
        description:
            " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        verified: true,
        islam: "ملتزمـ / ـة جدا",
        perspective: "بعد مقابلة الأهل",
        conditions: "أبحث عن شخص متدين وملتزم",
      ),
      otherUserInfo: [
        UserInfoUiModel(
          id: 1,
          firstName: "عبد الله",
          gender: "Female",
          marriageType: "زواج تقليدي",
          age: 28,
          nationality: "السعودية",
          countryOfResidence: "السعودية",
          city: "السعودية",
          education: "البكالوريوس",
          income: RangeValues(0, 6000),
          smokingHabit: "أحاول تركه",
          drinkingHabit: "لا أشرب",
          exerciseFrequency: "كل يوم",
          pets: ["Cat"],
          skinColor: "أسمر",
          tribe: "",
          acceptNationality: false,
          martialStatus: "اعزب",
          kids: "ليس لدي أطفال",
          look: "وسيم",
          hair: "ناعم",
          health: "سليمـ / ـة",
          diamondCount: 3,
          online: true,
          height: 180.5,
          weight: 100,
          position: "حكومي",
          messageCount: 140,
          islam: "ملتزمـ / ـة جدا",
          perspective: "بعد مقابلة الأهل",
          conditions: "أبحث عن شخص متدين وملتزم",
          description:
              " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        ),
        UserInfoUiModel(
          id: 2,
          firstName: "عبد",
          gender: "Female",
          marriageType: "اعزب",
          age: 28,
          nationality: "السعودية",
          countryOfResidence: "السعودية",
          city: "السعودية",
          education: "البكالوريوس",
          income: RangeValues(0, 6000),
          smokingHabit: "أحاول تركه",
          drinkingHabit: "لا أشرب",
          exerciseFrequency: "كل يوم",
          pets: ["Cat", "Dog"],
          skinColor: "أسمر",
          tribe: "",
          acceptNationality: false,
          martialStatus: "اعزب",
          kids: "لدي أطفال وسيظلون معي",
          look: "وسيم",
          hair: "ناعم",
          health: "سليمـ / ـة",
          diamondCount: 3,
          online: true,
          height: 180.5,
          weight: 100,
          position: "حكومي",
          messageCount: 140,
          islam: "ملتزمـ / ـة جدا",
          perspective: "بعد مقابلة الأهل",
          conditions: "أبحث عن شخص متدين وملتزم",
          description:
              " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        ),
        UserInfoUiModel(
          id: 3,
          firstName: "عبد الله",
          gender: "Female",
          marriageType: "اعزب",
          age: 28,
          nationality: "السعودية",
          countryOfResidence: "السعودية",
          city: "السعودية",
          education: "البكالوريوس",
          income: RangeValues(0, 6000),
          smokingHabit: "أحاول تركه",
          drinkingHabit: "لا أشرب",
          exerciseFrequency: "كل يوم",
          pets: ["Cat"],
          skinColor: "أسمر",
          tribe: "",
          acceptNationality: false,
          martialStatus: "اعزب",
          kids: "مع والدهم",
          look: "وسيم",
          hair: "ناعم",
          health: "سليمـ / ـة",
          diamondCount: 3,
          online: true,
          height: 180.5,
          weight: 100,
          position: "حكومي",
          messageCount: 140,
          islam: "ملتزمـ / ـة جدا",
          perspective: "بعد مقابلة الأهل",
          conditions: "أبحث عن شخص متدين وملتزم",
          description:
              " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [userInfo, otherUserInfo];
}
