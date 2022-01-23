import 'dart:io' show Platform;
import 'dart:convert';
import 'package:blitter_flutter_app/data/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:blitter_flutter_app/data/exceptions.dart';
import './signin_state.dart';
import '../blocs/blocs.dart';
import '../repositories/repositories.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthBloc authBloc;
  final ContactBloc contactBloc;
  final APIRepository apiRepository;
  final APISerializerRepository apiSerializerRepository;
  final AsyncCallback codeSentHandler;
  final AsyncCallback verificationCompletedHandler;
  final AsyncValueSetter<AuthException> verificationFailedHandler;
  FirebaseAuth? auth;

  SigninCubit({
    required this.authBloc,
    required this.contactBloc,
    required this.apiRepository,
    required this.apiSerializerRepository,
    required this.codeSentHandler,
    required this.verificationCompletedHandler,
    required this.verificationFailedHandler,
  }) : super(SigninState()) {
    if (Platform.isAndroid) {
      auth = FirebaseAuth.instance;
    }
  }

  Future<void> _signinAPICall(String? firebaseId) async {
    firebaseId ??= state.phoneNumber;
    final apiRes = await apiRepository.signIn(
      apiSerializerRepository.signInRequestSerializer({
        'phoneNumber': '+91${state.phoneNumber}',
        'firebaseId': firebaseId,
      }),
    );
    final apiResBody = apiSerializerRepository.signInResponseSerializer(
      jsonDecode(apiRes.body),
    );
    authBloc.add(
      UserLoggedIn.fromJson({
        ...apiResBody,
        'firebaseId': firebaseId,
      }),
    );
  }

  Future<void> _sendOTP() async {
    await auth?.verifyPhoneNumber(
      phoneNumber: '+91${state.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        final firebaseUserCredential =
            await auth?.signInWithCredential(credential);
        await _signinAPICall(firebaseUserCredential?.user?.uid);
        await verificationCompletedHandler();
      },
      codeSent: (String verificationId, int? resendToken) async {
        emit(state.copyWith(verificationId: verificationId));
        await codeSentHandler();
      },
      verificationFailed: (FirebaseAuthException e) async {
        await verificationFailedHandler(
          AuthException(
            code: e.code,
            message: e.message,
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> _skipFirebasePhoneAuth() async {
    await _signinAPICall(null);
    await verificationCompletedHandler();
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

  Future<void> signin() async {
    try {
      if (Platform.isAndroid) {
        await _sendOTP();
      } else {
        await _skipFirebasePhoneAuth();
      }
    } on FirebaseAuthException catch (e) {
      await verificationFailedHandler(
        AuthException(
          code: e.code,
          message: e.message,
        ),
      );
    } on Exception catch (e) {
      await verificationFailedHandler(
        AuthException(
          code: 'unknown',
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId, smsCode: state.code);
    try {
      final firebaseUserCredential =
          await auth?.signInWithCredential(credential);
      await _signinAPICall(firebaseUserCredential?.user?.uid);
      await verificationCompletedHandler();
    } on FirebaseAuthException catch (e) {
      await verificationFailedHandler(
        AuthException(
          code: e.code,
          message: e.message,
        ),
      );
    } on Exception catch (e) {
      await verificationFailedHandler(
        AuthException(
          code: 'unknown',
          message: e.toString(),
        ),
      );
    }
  }

  Future _fetchContactsHandler() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      final phoneNumber = <String>{};

      for (var contact in contacts) {
        contact.phones?.forEach((numberObj) {
          var number = numberObj.value?.replaceAll(RegExp('/-|\\s|(|)/g'), "");
          if (number != null) {
            if (number.startsWith("0751") ||
                number.startsWith('+') && !number.startsWith('+91')) {
              return;
            } else if (number.startsWith('0') && number.length == 11) {
              number = "+91" + number.substring(1);
            } else if (number.length == 10) {
              number = "+91" + number;
            }

            if (number.length == 13) {
              phoneNumber.add(number);
            }
          }
        });
      }
      final phoneNumberList = phoneNumber.toList();
      return phoneNumberList;
    } else {
      return [];
    }
  }

  Future<void> _syncContactsHandler() async {
    final List<String> phoneNumberList;
    if (Platform.isAndroid || Platform.isIOS) {
      phoneNumberList = await _fetchContactsHandler();
    } else {
      phoneNumberList = ['+919643966069', '+918223909888'];
    }

    final apiRes = await apiRepository.fetchUserProfiles(apiSerializerRepository
        .fetchUserProfilesRequestSerializer(phoneNumberList));
    contactBloc.add(InitializeContactState(apiSerializerRepository
        .fetchUserProfilesResponseSerializer(jsonDecode(apiRes.body))));
  }

  Future<void> _updateProfileHandler(JsonMap profileData) async {
    final apiRes = await apiRepository.updateProfile(profileData);
    final apiResBody = apiSerializerRepository.updateProfileResponseSerializer(
        jsonDecode(await apiRes.stream.bytesToString()));

    authBloc.add(UserProfileUpdated.fromJson(apiResBody));
  }

  Future<void> initializeApp(JsonMap profileData) async {
    await _updateProfileHandler(profileData);
    await _syncContactsHandler();
  }
}
