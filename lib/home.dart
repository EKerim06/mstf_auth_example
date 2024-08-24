import 'package:auth_mstf/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final AuthCubit viewModel;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    viewModel = AuthCubit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    final RegExp passwordRegexp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
    );

    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) => viewModel,
        child: Scaffold(
          appBar: AppBar(),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              state.isLoad;
            },
            builder: (context, state) {
              return state.isLoad
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                          ),
                          validator: (value) {
                            if (value?.isNotEmpty ?? false || value != null) {
                              if (emailRegExp.hasMatch(value!)) {
                                return null;
                              } else {
                                return 'Gecersiz eposta';
                              }
                            }
                            return 'Lutfen eposta girin';
                          },
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value?.isNotEmpty ?? false || value != null) {
                              if (passwordRegexp.hasMatch(value!)) {
                                return null;
                              } else {
                                return 'gecerli bir password kullanin';
                              }
                            }
                            return 'lutfen sifre giriniz';
                          },
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              viewModel.authLogic(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Gerekli bilgileri kontrol edin'),
                                ),
                              );
                            }
                          },
                          child: const Text('Devam'),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
