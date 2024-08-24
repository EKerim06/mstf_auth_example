import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState(deneme: 0)) {
    auth = FirebaseAuth.instance;
  }
  late final FirebaseAuth auth;

  bool isLoading = false;

  int value = 0;

  void plus() {
    value++;
    emit(state.copyWith(deneme: value));
  }

  Future<void> authLogic(
      {required String email, required String password}) async {
    _loadState();
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    _loadState();
  }

  void _loadState() {
    isLoading = !isLoading;
    emit(state.copyWith(isLoad: isLoading));
  }
}
