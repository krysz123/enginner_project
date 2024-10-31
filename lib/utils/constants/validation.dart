class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName jest wymagane';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Adres e-mail jest wymagany.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Nieprawidłowy adres e-mail.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hasło jest wymagane.';
    }

    if (value.length < 6) {
      return 'Hasło musi mieć co najmniej 6 znaków.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Hasło musi zawierać co najmniej jedną wielką literę.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Hasło musi zawierać co najmniej jedną cyfrę.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Hasło musi zawierać co najmniej jeden znak specjalny.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numer telefonu jest wymagany.';
    }

    final phoneRegExp = RegExp(r'^\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Nieprawidłowy format numeru telefonu (wymagane 9 cyfr).';
    }

    return null;
  }

  static String? validateNumbersOnly(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wartość jest wymagana';
    }

    final numbersOnlyRegExp = RegExp(r'^\d+([.,]\d+)?$');

    if (!numbersOnlyRegExp.hasMatch(value)) {
      return 'Wartość może zawierać tylko liczby całkowite lub zmiennoprzecinkowe';
    }

    return null;
  }

  static String? validateOptionalNumbersOnly(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final numbersOnlyRegExp = RegExp(r'^\d+([.,]\d+)?$');

    if (!numbersOnlyRegExp.hasMatch(value)) {
      return 'Wartość może zawierać tylko liczby całkowite lub zmiennoprzecinkowe';
    }

    return null;
  }

  static String? validateDropdownSelection(String? value) {
    const defaultOption = null;

    if (value == null || value == defaultOption) {
      return 'Proszę wybrać opcję.';
    }

    return null;
  }
}
