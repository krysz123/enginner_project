class CustomFormatException implements Exception {
  final String message;

  const CustomFormatException(
      [this.message =
          'Wystąpił nieoczekiwany błąd formatu. Proszę sprawdzić swoje dane wejściowe.']);

  factory CustomFormatException.fromMessage(String message) {
    return CustomFormatException(message);
  }

  String get formattedMessage => message;

  factory CustomFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CustomFormatException(
            'Format adresu e-mail jest nieprawidłowy.');
      case 'invalid-phone-number-format':
        return const CustomFormatException(
            'Format podanego numeru telefonu jest nieprawidłowy.');
      case 'invalid-date-format':
        return const CustomFormatException('Format daty jest nieprawidłowy.');
      case 'invalid-url-format':
        return const CustomFormatException('Format URL jest nieprawidłowy.');
      case 'invalid-numeric-format':
        return const CustomFormatException(
            'Dane wejściowe powinny być w prawidłowym formacie numerycznym.');
      default:
        return const CustomFormatException();
    }
  }
}
