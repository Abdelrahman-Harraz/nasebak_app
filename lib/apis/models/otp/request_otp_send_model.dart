class RequestOtpSendModelApi {
  final String mobile;

  const RequestOtpSendModelApi({required this.mobile});

  Map<String, dynamic> toMap() {
    return {"mobile": mobile};
  }
}
