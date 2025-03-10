import 'dart:async';
import 'dart:ui';
import 'package:nasebak_app/apis/models/subscription/subscription_api_model.dart';

class SubscriptionUiModel {
  final DateTime? endDate;
  final String subscriptionType;
  final String packageType;
  VoidCallback? onUpdate;
  Timer? _timer;

  SubscriptionUiModel({
    this.endDate,
    required this.subscriptionType,
    required this.packageType,
  });

  factory SubscriptionUiModel.fromApiModel(SubscriptionApiModel e) {
    return SubscriptionUiModel(
      endDate: DateTime.parse(e.endDate),
      subscriptionType: e.subscriptionType,
      packageType: e.packageType,
    );
  }

  factory SubscriptionUiModel.dummy() {
    return SubscriptionUiModel(
      endDate: DateTime.now().add(
        Duration(days: 8, hours: 5, minutes: 43, seconds: 10),
      ),
      subscriptionType: "شهري",
      packageType: "الذهبية",
    );
  }

  Duration get remainingTime {
    final now = DateTime.now();
    return endDate!.isAfter(now) ? endDate!.difference(now) : Duration.zero;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime == Duration.zero) {
        stopTimer();
      }
      onUpdate?.call();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}
