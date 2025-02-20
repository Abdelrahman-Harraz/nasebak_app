import 'package:equatable/equatable.dart';

class GetUserInfoApiModel extends Equatable {
  final int id;

  final String firstName;

  const GetUserInfoApiModel({required this.id, required this.firstName});

  factory GetUserInfoApiModel.fromJson(Map<String, dynamic> json) {
    return GetUserInfoApiModel(
      id: json['id'] as int,

      firstName: json['first_name'] as String,
    );
  }

  @override
  List<Object?> get props => [id, firstName];
}
