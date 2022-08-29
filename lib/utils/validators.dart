class Validator {
  static String? validateEmpty(
      {String field = '', required String? value, String? errorMessage}) {
    return value == null || value.isEmpty
        ? errorMessage ?? 'Silahkan masukkan $field'
        : null;
  }

  static String? validateEmail(String email) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? validatePassword(String password) {
    // min 6 characters
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // must have number and special character
    if (!RegExp(r'^(?=.*[0-9])(?=.*[!@#\$&*~]).*$').hasMatch(password)) {
      return 'Password must have at least one number and one special character';
    }

    return null;
  }

  static String? validatePasswordMatch(
      {required String password, required String confirmPassword}) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
