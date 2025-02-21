import 'package:equatable/equatable.dart';

class GetUserInfoApiModel extends Equatable {
  final int id;
  final String firstName;
  final String gender;
  final String marriageType;
  final String? userNotes;
  final String? userDescription;

  const GetUserInfoApiModel({
    required this.gender,
    required this.marriageType,
    required this.id,
    required this.firstName,
    this.userNotes,
    this.userDescription,
  });

  factory GetUserInfoApiModel.fromJson(Map<String, dynamic> json) {
    return GetUserInfoApiModel(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      marriageType: json['marriage_type'] as String,
      gender: json['gender'] as String,
      userNotes: json['user_notes'] as String,
      userDescription: json['user_description'] as String,
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
  ];
}
