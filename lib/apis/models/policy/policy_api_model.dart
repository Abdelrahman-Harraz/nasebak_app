import 'package:equatable/equatable.dart';

class PolicyApiModel extends Equatable {
  final String title;
  final String description;

  const PolicyApiModel({required this.title, required this.description});

  factory PolicyApiModel.fromJson(Map<String, dynamic> json) {
    return PolicyApiModel(
      title: json['policy_title'],
      description: json['policy_description'],
    );
  }

  @override
  List<Object?> get props => [title, description];
}
