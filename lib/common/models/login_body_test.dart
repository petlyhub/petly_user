class LoginBody {
  String phone;
  String otp;

  LoginBody({required this.phone, required this.otp});

  Map<String, String> toJson() {
    return {
      "phone": phone,
      "otp": otp,
    };
  }
}