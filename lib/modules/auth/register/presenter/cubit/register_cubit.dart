import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';
import 'package:surf_app/infrastructure/extensions/valid_email.dart';
import 'package:surf_app/modules/auth/register/presenter/usecase/i_register_usecase.dart';

part 'register_state.dart';

@Injectable()
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this._registerUC,
  ) : super(RegisterInitial());

  final IRegisterUseCase _registerUC;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Future<void> register() async {
    emit(RegisterLoadingState());
    var res = await _registerUC.registerUser(
        nameController.text, emailController.text, passwordController.text);

    res.fold((error) => emit(RegisterErrorState(error: error)),
        (result) => emit(RegisterLoadedState()));
  }

  String validateName(String text) {
    if (text == null || text == '') {
      return 'Campo Obrigatorio';
    }
    return null;
  }

  String validateSenha(String text) {
    if (text == null || text == '') {
      return 'Campo Obrigatorio';
    } else if (text.length < 6) {
      return 'Digite uma senha maior que 6 caracteres';
    }
    return null;
  }

  String validateEmail(String text) {
    if (text.isValidEmail()) {
      return null;
    }
    return 'Email invalido';
  }
}
