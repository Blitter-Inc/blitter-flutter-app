class AuthException {
  final String code;
  final String? message;

  AuthException({
    required this.code,
    this.message,
  });
}

class AuthExceptionMessage {
  static const firebaseAuthExceptionMessages = {
    'invalid-verification-code': 'Invalid OTP provided',
    'invalid-phone-number': 'Please provide a valid phone number',
    'too-many-requests': 'Firebase API rate limiting',
  };

  static String getErrorMessageFromCode(String code) {
    return firebaseAuthExceptionMessages[code] ?? 'Unknown error occured!';
  }
}
