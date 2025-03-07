class SubscriptionApiModel {
  final String endDate;
  final String subscriptionType;
  final String packageType;

  SubscriptionApiModel({
    required this.endDate,
    required this.subscriptionType,
    required this.packageType,
  });

  factory SubscriptionApiModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionApiModel(
      endDate: json['endDate'],
      subscriptionType: json['subscriptionType'],
      packageType: json['packageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'endDate': endDate,
      'subscriptionType': subscriptionType,
      'packageType': packageType,
    };
  }
}
