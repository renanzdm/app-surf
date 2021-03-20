import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';
import 'package:surf_app/modules/auth/login/presenter/usecases/i_login_usecase.dart';
import 'package:surf_app/infrastructure/extensions/valid_email.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._loginUC,
  ) : super(LoginInitialState());

  final ILoginUseCase _loginUC;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Future<void> login() async {
    emit(LoginLoadingState());
    Future.delayed(const Duration(seconds: 1));
    var res =
        await _loginUC.loginUser(emailController.text, passwordController.text);
    res.fold((error) => emit(LoginErrorState(error: error)),
        (result) => emit(LoginLoadedState()));
  }

  String? validatePassword(String? text) {
    if (text == null && text == '') {
      return 'Campo Obrigatorio';
    } else if (text!.length < 6) {
      return 'Digite uma senha maior que 6 caracteres';
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text!.isValidEmail()) {
      return null;
    }
    return 'Email invalido';
  }
}
