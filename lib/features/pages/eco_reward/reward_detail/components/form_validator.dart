class RewardFormValidator {
  static String? validateEmail(String? email) {
    if (email == null) return 'Email cannot be empty';
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? validateNumber(String? number) {
    if (number == null) return 'Number cannot be empty';
    if (number.isEmpty) {
      return 'Number cannot be empty';
    }
    if (number.length < 10) {
      return 'Invalid number';
    }
    return null;
  }
}
