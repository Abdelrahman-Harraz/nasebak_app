import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nasebak_app/apis/models/home/home_api_model.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';

class HomeUiModel extends Equatable {
  final List<UserInfoUiModel> userInfo;

  const HomeUiModel({required this.userInfo});

  factory HomeUiModel.fromApi(HomeApiModel e) {
    return HomeUiModel(
      userInfo:
          e.otherUserInfo
              .map((userInfo) => UserInfoUiModel.fromApi(userInfo))
              .toList(),
    );
  }

  factory HomeUiModel.dummy() {
    return HomeUiModel(
      userInfo: [
        UserInfoUiModel(
          id: 1,
          firstName: "عبد الله",
          mobileNumber: "",
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
          online: false,
          height: 180.5,
          weight: 100,
          position: "حكومي",
          messageCount: 140,
          islam: "ملتزمـ / ـة جدا",
          perspective: "بعد مقابلة الأهل",
          conditions: "أبحث عن شخص متدين وملتزم",
          goldenMembership: false,
          description:
              " سعودي الجنسية ابحث على زوجة صالحة وزواج علني , زوجة تقدر الحياة ...الزوجية",
        ),
        UserInfoUiModel(
          id: 2,
          firstName: "عبد",
          mobileNumber: "",
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
          goldenMembership: false,
          look: "وسيم",
          hair: "ناعم",
          health: "سليمـ / ـة",
          diamondCount: 3000,
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
          mobileNumber: "",
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
          goldenMembership: false,
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
        UserInfoUiModel(
          id: 4,
          firstName: "عبد الله",
          mobileNumber: "",
          gender: "Female",
          marriageType: "اعزب",
          age: 28,
          nationality: "السعودية",
          countryOfResidence: "السعودية",
          goldenMembership: true,
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
  List<Object?> get props => [userInfo];
}
