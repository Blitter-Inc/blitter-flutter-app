class SigninState {
  final String phoneNumber;
  final String verificationId;
  final String code;

  SigninState({
    this.phoneNumber = '',
    this.verificationId = '',
    this.code = '',
  });

  SigninState copyWith({
    String? phoneNumber,
    String? verificationId,
    String? code,
  }) =>
      SigninState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        code: code ?? this.code,
      );
}
