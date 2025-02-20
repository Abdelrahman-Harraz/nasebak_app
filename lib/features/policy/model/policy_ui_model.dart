import 'package:nasebak_app/apis/models/policy/policy_api_model.dart';

class PolicyUiModel {
  final String title;
  final String description;

  const PolicyUiModel({required this.title, required this.description});

  factory PolicyUiModel.fromJson(PolicyApiModel e) {
    return PolicyUiModel(title: e.title, description: e.description);
  }

  static List<PolicyUiModel> dummyPolicies = [
    PolicyUiModel(
      title: "الحفاظ على الأخلاق والقيم",
      description:
          "يجب على جميع المستخدمين احترام القيم الأخلاقية والدينية، والامتناع عن أي سلوك غير لائق أو مسيء.",
    ),
    PolicyUiModel(
      title: "الدقة والمصداقية",
      description: " يجب على المستخدمين تقديم معلومات دقيقة وصحيحة عن أنفسهم",
    ),
    PolicyUiModel(
      title: "الخصوصية",
      description:
          "يجب احترام خصوصية الآخرين وعدم نشر أي معلومات شخصية دون موافقتهم",
    ),
    PolicyUiModel(
      title: "الاحترام المتبادل",
      description:
          "يجب على المستخدمين معاملة الآخرين باحترام وتقدير، وتجنب أي نوع من التحرش أو التمييز.",
    ),
    PolicyUiModel(
      title: "الاستخدام المشروع",
      description:
          "يجب استخدام التطبيق للأغراض المخصصة له فقط، وعدم استخدامه لأي أغراض غير مشروعة أو مخالفة للقانون.",
    ),
  ];
}
