class ValidatorsAuth {
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email required';
    final emailReg = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailReg.hasMatch(v)) return 'Email format is incorrect';
    return null;
  }

  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Password required';
    if (v.length < 8) return 'Must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(v))
      return 'Must contain at least one capital letter.';
    if (!RegExp(r'[a-z]').hasMatch(v))
      return 'Must contain at least one lowercase letter.';
    if (!RegExp(r'\d').hasMatch(v)) return 'Must contain at least one number';

    return null;
  }

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Name required';
    if (v.length < 2) return 'Must be at least 2 characters';
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }
}
