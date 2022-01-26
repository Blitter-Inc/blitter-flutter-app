class SigninState {
  final String phoneNumber;
  final String verificationId;
  final String code;
  final String profileDataJson;

  SigninState({
    this.phoneNumber = '',
    this.verificationId = '',
    this.code = '',
    this.profileDataJson = '{}',
  });

  SigninState copyWith({
    String? phoneNumber,
    String? verificationId,
    String? code,
    String? profileDataJson,
  }) =>
      SigninState(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        code: code ?? this.code,
        profileDataJson: profileDataJson ?? this.profileDataJson,
      );
}
