class CustomFirebaseException implements Exception {
  final String code;

  CustomFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'Wystąpił nieznany błąd Firebase. Proszę spróbować ponownie.';
      case 'invalid-custom-token':
        return 'Format niestandardowego tokena jest nieprawidłowy. Proszę sprawdzić swój niestandardowy token.';
      case 'custom-token-mismatch':
        return 'Niestandardowy token odpowiada innej publiczności.';
      case 'user-disabled':
        return 'Konto użytkownika zostało zablokowane.';
      case 'user-not-found':
        return 'Nie znaleziono użytkownika dla podanego adresu e-mail lub UID.';
      case 'invalid-email':
        return 'Podany adres e-mail jest nieprawidłowy.';
      case 'email-already-in-use':
        return 'Adres e-mail jest już zarejestrowany.';
      case 'wrong-password':
        return 'Nieprawidłowe hasło.';
      case 'weak-password':
        return 'Hasło jest zbyt słabe. Proszę wybrać silniejsze hasło.';
      case 'provider-already-linked':
        return 'Konto jest już połączone z innym dostawcą.';
      case 'operation-not-allowed':
        return 'Ta operacja jest niedozwolona.';
      case 'invalid-credential':
        return 'Podane dane uwierzytelniające są uszkodzone lub wygasły.';
      case 'invalid-verification-code':
        return 'Nieprawidłowy kod weryfikacyjny.';
      case 'invalid-verification-id':
        return 'Nieprawidłowy identyfikator weryfikacyjny.';
      case 'captcha-check-failed':
        return 'Odpowiedź reCAPTCHA jest nieprawidłowa.';
      case 'app-not-authorized':
        return 'Aplikacja nie jest autoryzowana do korzystania z Firebase Authentication z podanym kluczem API.';
      case 'keychain-error':
        return 'Wystąpił błąd keychain. Proszę sprawdzić keychain i spróbować ponownie.';
      case 'internal-error':
        return 'Wystąpił wewnętrzny błąd uwierzytelniania. Proszę spróbować ponownie później.';
      case 'invalid-app-credential':
        return 'Dane uwierzytelniające aplikacji są nieprawidłowe. Proszę podać prawidłowe dane uwierzytelniające aplikacji.';
      case 'user-mismatch':
        return 'Podane dane uwierzytelniające nie odpowiadają wcześniej zalogowanemu użytkownikowi.';
      case 'requires-recent-login':
        return 'Ta operacja jest wrażliwa i wymaga ostatniego uwierzytelnienia. Proszę zalogować się ponownie.';
      case 'quota-exceeded':
        return 'Przekroczono limit. Proszę spróbować ponownie później.';
      case 'account-exists-with-different-credential':
        return 'Konto już istnieje z tym samym adresem e-mail, ale innymi danymi logowania.';
      case 'missing-iframe-start':
        return 'W szablonie e-mail brakuje tagu początkowego iframe.';
      case 'missing-iframe-end':
        return 'W szablonie e-mail brakuje tagu końcowego iframe.';
      case 'missing-iframe-src':
        return 'W szablonie e-mail brakuje atrybutu src iframe.';
      case 'auth-domain-config-required':
        return 'Konfiguracja authDomain jest wymagana dla linku weryfikacji kodu akcji.';
      case 'missing-app-credential':
        return 'Brak danych uwierzytelniających aplikacji. Proszę podać prawidłowe dane uwierzytelniające aplikacji.';
      case 'session-cookie-expired':
        return 'Plik cookie sesji Firebase wygasł. Proszę zalogować się ponownie.';
      case 'uid-already-exists':
        return 'Podany identyfikator użytkownika jest już używany przez innego użytkownika.';
      case 'web-storage-unsupported':
        return 'Przechowywanie w sieci nie jest obsługiwane lub jest wyłączone.';
      case 'app-deleted':
        return 'Ta instancja FirebaseApp została usunięta.';
      case 'user-token-mismatch':
        return 'Token użytkownika nie pasuje do identyfikatora użytkownika uwierzytelnionego użytkownika.';
      case 'invalid-message-payload':
        return 'Ładunek wiadomości szablonu e-mail weryfikacyjnego jest nieprawidłowy.';
      case 'invalid-sender':
        return 'Nadawca szablonu e-mail jest nieprawidłowy. Proszę zweryfikować adres e-mail nadawcy.';
      case 'invalid-recipient-email':
        return 'Adres e-mail odbiorcy jest nieprawidłowy. Proszę podać prawidłowy adres e-mail odbiorcy.';
      case 'missing-action-code':
        return 'Brak kodu akcji. Proszę podać prawidłowy kod akcji.';
      case 'user-token-expired':
        return 'Token użytkownika wygasł i wymaga uwierzytelnienia. Proszę zalogować się ponownie.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Nieprawidłowe dane logowania.';
      case 'expired-action-code':
        return 'Kod akcji wygasł. Proszę poprosić o nowy kod akcji.';
      case 'invalid-action-code':
        return 'Kod akcji jest nieprawidłowy. Proszę sprawdzić kod i spróbować ponownie.';
      case 'credential-already-in-use':
        return 'Te dane uwierzytelniające są już powiązane z innym kontem użytkownika.';
      default:
        return 'Wystąpił nieoczekiwany błąd Firebase. Proszę spróbować ponownie.';
    }
  }
}
