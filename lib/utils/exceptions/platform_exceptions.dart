class CustomPlatformException implements Exception {
  final String code;

  CustomPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Nieprawidłowe dane logowania.';
      case 'too-many-requests':
        return 'Zbyt wiele żądań. Proszę spróbować ponownie później.';
      case 'invalid-argument':
        return 'Nieprawidłowy argument przekazany do metody uwierzytelnienia.';
      case 'invalid-password':
        return 'Nieprawidłowe hasło.';
      case 'invalid-phone-number':
        return 'Podany numer telefonu jest nieprawidłowy.';
      case 'operation-not-allowed':
        return 'Dostawca logowania jest wyłączony dla Twojego projektu Firebase.';
      case 'session-cookie-expired':
        return 'Plik cookie sesji Firebase wygasł. Proszę zalogować się ponownie.';
      case 'uid-already-exists':
        return 'Podany identyfikator użytkownika jest już używany przez innego użytkownika.';
      case 'sign_in_failed':
        return 'Logowanie nie powiodło się.';
      case 'network-request-failed':
        return 'Żądanie sieciowe nie powiodło się. Proszę sprawdzić swoje połączenie internetowe.';
      case 'internal-error':
        return 'Błąd wewnętrzny. Proszę spróbować ponownie później.';
      case 'invalid-verification-code':
        return 'Nieprawidłowy kod weryfikacyjny. Proszę wprowadzić prawidłowy kod.';
      case 'invalid-verification-id':
        return 'Nieprawidłowy identyfikator weryfikacyjny.';
      case 'quota-exceeded':
        return 'Przekroczono limit. Proszę spróbować ponownie później.';
      default:
        return 'Wystąpił nieoczekiwany błąd. Proszę spróbować ponownie.';
    }
  }
}
