class ValidationMixins {
  String validateEmail(String value) {
    if (value.contains('@')) return null;
    return "Email not valid";
  }

  String validatePassword(String value) {
    if (value.length > 6) return null;
    return "Password must be at least 6 characters";
  }
}
