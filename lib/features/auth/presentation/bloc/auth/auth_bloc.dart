import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_today/features/auth/data/models/user.dart';
import 'package:employees_today/features/auth/domain/entities/user.dart';
import 'package:employees_today/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthInitial()) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final userSnapshot =
            await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

        final currentUser = UserModel.fromJson(userSnapshot.data() as Map<String, Object?>);

        emit(
          SignInSuccessState(
            user: currentUser,
          ),
        );
      } else {
        emit(AuthInitial());
      }
    });

    on<VerifyNumberEvent>(_onVerifyNumber);
    on<SignInEvent>(_onSignIn);
  }

  _onVerifyNumber(VerifyNumberEvent event, Emitter<AuthState> emit) async {
    emit(VerifyNumberLoadingState());

    final firebaseInstance = FirebaseAuth.instance;
    final completer = Completer<void>();

    await firebaseInstance.verifyPhoneNumber(
      phoneNumber: event.number,
      verificationCompleted: (phoneAuthCredential) async {
        await firebaseInstance.signInWithCredential(phoneAuthCredential);
        if (!completer.isCompleted) completer.complete();
      },
      verificationFailed: (error) {
        log("Verification Failed: ${error.toString()}");
        emit(VerifyNumberFailedState(error: error.toString()));
        if (!completer.isCompleted) completer.complete();
      },
      codeSent: (verificationId, forceResendingToken) {
        emit(VerifyNumberSuccessState(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (!completer.isCompleted) completer.complete();
      },
    );

    await completer.future;
  }

  _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(SignInLoadingState());

    final res = await _repository.signin(event.verificationId, event.otpCode);

    res.fold(
      (l) {
        emit(SignInFailedState(error: l));
      },
      (r) {
        emit(SignInSuccessState(user: r));
      },
    );
  }
}
