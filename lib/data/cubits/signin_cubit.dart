import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './signin_state.dart';
import '../repositories/repositories.dart';

class SigninCubit extends Cubit<SigninState> {
  final AsyncCallback codeSent;
  final AsyncCallback verificationCompleted;
  final AsyncCallback verificationFailed;

  SigninCubit({
    required this.codeSent,
    required this.verificationCompleted,
    required this.verificationFailed,
  }) : super(SigninState()) {
    if (Platform.isAndroid) {
      auth = FirebaseAuth.instance;
    }
  }

  FirebaseAuth? auth;
  final _apiRepository = APIRepository();
  final _apiSerializerRepository = APISerializerRepository();

  Future<void> _signinAPICall(String? firebaseId) async {
    final apiRes = await _apiRepository.signIn(
      _apiSerializerRepository.signInRequestSerializer({
        'phoneNumber': '+91${state.phoneNumber}',
        'firebaseId': firebaseId ?? state.phoneNumber,
      }),
    );
    final apiResBody = jsonDecode(apiRes.body);
    // Put user info into state
    print(apiResBody);
  }

  void setPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void setFirebaseVerificationId(String verificationId) {
    emit(state.copyWith(verificationId: verificationId));
  }

  void setCode(String code) {
    emit(state.copyWith(code: code));
  }

  Future<void> sendOTP() async {
    await auth?.verifyPhoneNumber(
      phoneNumber: '+91${state.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        final res = await auth?.signInWithCredential(credential);
        // Do something with credentials here
        print(res);
        await verificationCompleted();
      },
      codeSent: (String verificationId, int? resendToken) async {
        emit(state.copyWith(verificationId: verificationId));
        await codeSent();
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('AutoCodeRetrievalTimeout: $verificationId');
      },
    );
  }

  Future<void> verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: state.code);
    final firebaseUserCredential = await auth?.signInWithCredential(credential);
    print(firebaseUserCredential);
    await _signinAPICall(firebaseUserCredential?.user?.uid);
    await verificationCompleted();
  }

  Future<void> skipFirebasePhoneAuth() async {
    await _signinAPICall(null);
    await verificationCompleted();
  }
}
