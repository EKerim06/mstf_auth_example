// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({this.deneme, this.isLoad = false});

  final bool isLoad;
  final int? deneme;

  @override
  List<Object?> get props => [
        deneme,
        isLoad,
      ];

  AuthState copyWith({
    int? deneme,
    bool isLoad = false,
  }) {
    return AuthState(
      deneme: deneme ?? this.deneme,
      isLoad: false,
    );
  }
}
