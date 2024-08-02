class CustomFirebaseAuthException implements Exception {
  final String code;

  CustomFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'Adres e-mail jest już zarejestrowany.';
      case 'invalid-email':
        return 'Podany adres e-mail jest nieprawidłowy.';
      case 'weak-password':
        return 'Hasło jest zbyt słabe. Proszę wybrać silniejsze hasło.';
      case 'user-disabled':
        return 'To konto użytkownika zostało zablokowane.';
      case 'user-not-found':
        return 'Nieprawidłowe dane logowania.';
      case 'wrong-password':
        return 'Nieprawidłowe hasło.';
      case 'invalid-verification-code':
        return 'Nieprawidłowy kod weryfikacyjny.';
      case 'invalid-verification-id':
        return 'Nieprawidłowy identyfikator weryfikacyjny.';
      case 'quota-exceeded':
        return 'Przekroczono limit. Proszę spróbować ponownie później.';
      case 'email-already-exists':
        return 'Adres e-mail już istnieje.';
      case 'provider-already-linked':
        return 'Konto jest już połączone z innym dostawcą.';
      case 'requires-recent-login':
        return 'Ta operacja jest wrażliwa i wymaga ostatniego uwierzytelnienia. Proszę zalogować się ponownie.';
      case 'credential-already-in-use':
        return 'Te dane uwierzytelniające są już powiązane z innym kontem użytkownika.';
      case 'user-mismatch':
        return 'Podane dane uwierzytelniające nie odpowiadają wcześniej zalogowanemu użytkownikowi.';
      case 'account-exists-with-different-credential':
        return 'Konto już istnieje z tym samym adresem e-mail, ale innymi danymi logowania.';
      case 'operation-not-allowed':
        return 'Ta operacja jest niedozwolona. Proszę skontaktować się z pomocą techniczną.';
      case 'expired-action-code':
        return 'Kod akcji wygasł. Proszę poprosić o nowy kod akcji.';
      case 'invalid-action-code':
        return 'Kod akcji jest nieprawidłowy. Proszę sprawdzić kod i spróbować ponownie.';
      case 'missing-action-code':
        return 'Brak kodu akcji. Proszę podać prawidłowy kod akcji.';
      case 'user-token-expired':
        return 'Token użytkownika wygasł i wymaga uwierzytelnienia. Proszę zalogować się ponownie.';
      case 'invalid-credential':
        return 'Podane dane uwierzytelniające są uszkodzone lub wygasły.';
      case 'user-token-revoked':
        return 'Token użytkownika został unieważniony. Proszę zalogować się ponownie.';
      case 'invalid-message-payload':
        return 'Ładunek wiadomości szablonu e-mail weryfikacyjnego jest nieprawidłowy.';
      case 'invalid-sender':
        return 'Nadawca szablonu e-mail jest nieprawidłowy. Proszę zweryfikować adres e-mail nadawcy.';
      case 'invalid-recipient-email':
        return 'Adres e-mail odbiorcy jest nieprawidłowy. Proszę podać prawidłowy adres e-mail odbiorcy.';
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
      case 'invalid-app-credential':
        return 'Dane uwierzytelniające aplikacji są nieprawidłowe. Proszę podać prawidłowe dane uwierzytelniające aplikacji.';
      case 'session-cookie-expired':
        return 'Plik cookie sesji Firebase wygasł. Proszę zalogować się ponownie.';
      case 'uid-already-exists':
        return 'Podany identyfikator użytkownika jest już używany przez innego użytkownika.';
      case 'invalid-cordova-configuration':
        return 'Podana konfiguracja Cordova jest nieprawidłowa.';
      case 'app-deleted':
        return 'Ta instancja FirebaseApp została usunięta.';
      case 'user-token-mismatch':
        return 'Token użytkownika nie pasuje do identyfikatora użytkownika uwierzytelnionego użytkownika.';
      case 'web-storage-unsupported':
        return 'Przechowywanie w sieci nie jest obsługiwane lub jest wyłączone.';
      case 'app-not-authorized':
        return 'Aplikacja nie jest autoryzowana do korzystania z Firebase Authentication z podanym kluczem API.';
      case 'keychain-error':
        return 'Wystąpił błąd keychain. Proszę sprawdzić keychain i spróbować ponownie.';
      case 'internal-error':
        return 'Wystąpił wewnętrzny błąd uwierzytelniania. Proszę spróbować ponownie później.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Nieprawidłowe dane logowania.';
      default:
        return 'Wystąpił nieoczekiwany błąd uwierzytelniania. Proszę spróbować ponownie.';
    }
  }
}
