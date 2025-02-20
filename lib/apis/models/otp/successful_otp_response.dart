class SuccessfulOTPResponse {
  final int id;
  final String? name;
  final String? email;
  final String phone;
  final bool status;
  final String token;
  final bool isComplete;
  final String restoreId;

  const SuccessfulOTPResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.token,
    required this.isComplete,
    required this.restoreId,
  });

  factory SuccessfulOTPResponse.fromJson(Map<String, dynamic> json) =>
      SuccessfulOTPResponse(
        id: json['id'] as int,
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String,
        status: json['status'] as bool,
        token: json['token'] as String,
        isComplete: json["is_complete"],
        restoreId: json["restore_id"] ?? "",
      );
}
