class Exceptions implements Exception {
  final String message;

  const Exceptions(
      [this.message =
          'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.']);

  factory Exceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const Exceptions('Adres e-mail jest już zarejestrowany..');
      case 'invalid-email':
        return const Exceptions('Podany adres e-mail jest nieprawidłowy.');
      case 'email-already-exists':
        return const Exceptions('Adres e-mail już istnieje.');
      case 'weak-password':
        return const Exceptions(
            'Hasło jest zbyt słabe. Proszę wybrać silniejsze hasło.');
      case 'user-disabled':
        return const Exceptions('To konto użytkownika zostało zablokowane.');
      case 'user-not-found':
        return const Exceptions('Nieprawidłowe dane logowania.');
      case 'wrong-password':
        return const Exceptions('Nieprawidłowe hasło.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const Exceptions('Nieprawidłowe dane logowania.');
      case 'too-many-requests':
        return const Exceptions(
            'Zbyt wiele żądań. Proszę spróbować ponownie później.');
      case 'invalid-argument':
        return const Exceptions(
            'Nieprawidłowy argument przekazany do metody uwierzytelnienia.');
      case 'invalid-password':
        return const Exceptions('Nieprawidłowe hasło.');
      case 'invalid-phone-number':
        return const Exceptions('Podany numer telefonu jest nieprawidłowy.');
      case 'operation-not-allowed':
        return const Exceptions(
            'Dostawca logowania jest wyłączony dla Twojego projektu Firebase.');
      case 'session-cookie-expired':
        return const Exceptions(
            'Plik cookie sesji Firebase wygasł. Proszę zalogować się ponownie.');
      case 'uid-already-exists':
        return const Exceptions(
            'Podany identyfikator użytkownika jest już używany przez innego użytkownika.');
      case 'sign_in_failed':
        return const Exceptions(
            'Logowanie nie powiodło się. Proszę spróbować ponownie.');
      case 'network-request-failed':
        return const Exceptions(
            'Żądanie sieciowe nie powiodło się. Proszę sprawdzić swoje połączenie internetowe.');
      case 'internal-error':
        return const Exceptions(
            'Błąd wewnętrzny. Proszę spróbować ponownie później.');
      case 'invalid-verification-code':
        return const Exceptions(
            'Nieprawidłowy kod weryfikacyjny. Proszę wprowadzić prawidłowy kod.');
      case 'invalid-verification-id':
        return const Exceptions(
            'Nieprawidłowy identyfikator weryfikacyjny. Proszę poprosić o nowy kod weryfikacyjny.');
      case 'quota-exceeded':
        return const Exceptions(
            'Przekroczono limit. Proszę spróbować ponownie później.');
      default:
        return const Exceptions();
    }
  }
}
