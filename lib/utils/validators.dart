String? validateName(String? val) {
  if (val == null || val.trim().isEmpty) return 'Enter name';
  return null;
}

String? validatePhone(String? val) {
  if (val == null || val.trim().isEmpty) return 'Enter phone';
  if (val.length < 10) return 'Phone must be at least 10 digits';
  return null;
}

String? validateEmail(String? val) {
  if (val == null || val.trim().isEmpty) return 'Enter email';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(val)) return 'Enter a valid email';
  return null;
}
