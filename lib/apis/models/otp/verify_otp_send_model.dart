class VerifyOtpSendModelApi {
  final String username;
  final String otp;

  VerifyOtpSendModelApi(this.username, this.otp);

  Map<String, dynamic> toMap() {
    return {"mobile": username, "otp": otp};
  }
}
