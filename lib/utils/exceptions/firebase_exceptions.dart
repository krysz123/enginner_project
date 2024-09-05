class CustomFirebaseException implements Exception {
  final String message;

  const CustomFirebaseException(
      [this.message =
          'Wystąpił nieoczekiwany błąd formatu. Proszę sprawdzić swoje dane wejściowe.']);

  factory CustomFirebaseException.fromMessage(String message) {
    return CustomFirebaseException(message);
  }

  String get formattedMessage => message;

  factory CustomFirebaseException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const CustomFirebaseException(
            'Format adresu e-mail jest nieprawidłowy. Proszę wprowadzić prawidłowy adres e-mail.');
      case 'invalid-phone-number-format':
        return const CustomFirebaseException(
            'Format podanego numeru telefonu jest nieprawidłowy. Proszę wprowadzić prawidłowy numer.');
      case 'invalid-date-format':
        return const CustomFirebaseException(
            'Format daty jest nieprawidłowy. Proszę wprowadzić prawidłową datę.');
      case 'invalid-url-format':
        return const CustomFirebaseException(
            'Format URL jest nieprawidłowy. Proszę wprowadzić prawidłowy URL.');
      case 'invalid-credit-card-format':
        return const CustomFirebaseException(
            'Format karty kredytowej jest nieprawidłowy. Proszę wprowadzić prawidłowy numer karty kredytowej.');
      case 'invalid-numeric-format':
        return const CustomFirebaseException(
            'Dane wejściowe powinny być w prawidłowym formacie numerycznym.');
      default:
        return const CustomFirebaseException();
    }
  }
}
