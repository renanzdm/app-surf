import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_app/infrastructure/dependecy_injection/service_locator.dart';
import 'package:surf_app/modules/auth/register/domain/error/register_errors.dart';
import 'package:surf_app/modules/auth/register/presenter/cubit/register_cubit.dart';
import 'package:surf_app/shared/widgets/textfield_custom.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final cubit = getIt.get<RegisterCubit>();
  final _formKey = GlobalKey<FormState>();
  bool visiblePassword = true;

  @override
  void initState() {
    super.initState();
    cubit.listen((state) {
      if (state is RegisterErrorState) {
        BotToast.showNotification(
          title: (_) => Text('Erro ao cadastrar Usuário'),
          subtitle: (_) => state.error is RegisterErrorEmailInUse
              ? Text('Email ja se encontra em uso')
              : Text('Tente novamente em instantes'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 4),
          leading: (_) => Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 50,
          ),
        );
      } else if (state is RegisterLoadedState) {
        BotToast.showNotification(
          title: (_) => Text('Sucesso ao cadastrar o usuario'),
          subtitle: (_) => Text('Usuario cadastrado'),
          backgroundColor: Colors.greenAccent.shade200,
          duration: const Duration(seconds: 4),
          leading: (_) => Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 50,
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          image: AssetImage(
            'assets/images/3.jpg',
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .05,
                      ),
                      TextFieldCustom(
                        labelText: 'Nome',
                        prefixIcon: Icons.person_outline,
                        controller: cubit.nameController,
                        validator: cubit.validateName,
                      ),
                      TextFieldCustom(
                        labelText: 'E-mail',
                        prefixIcon: Icons.mail_outline,
                        controller: cubit.emailController,
                        // textInputType: TextInputType.emailAddress,
                        validator: cubit.validateEmail,
                      ),
                      TextFieldCustom(
                        labelText: 'Senha',
                        prefixIcon: Icons.lock_outline,
                        controller: cubit.passwordController,
                        obscureText: visiblePassword,
                        validator: cubit.validateSenha,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              visiblePassword = !visiblePassword;
                            });
                          },
                          child: visiblePassword
                              ? Icon(Icons.visibility_off_outlined,
                                  color: Colors.white)
                              : Icon(Icons.visibility, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .1,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              await cubit.register();
                            }
                          },
                          child: BlocBuilder<RegisterCubit, RegisterState>(
                            cubit: cubit,
                            buildWhen: (previous, state) => previous != state,
                            builder: (_, state) {
                              return AnimatedContainer(
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                height: 50,
                                width: state is RegisterLoadingState
                                    ? 50
                                    : constraints.maxWidth * .65,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: state is RegisterLoadingState
                                      ? BorderRadius.circular(32)
                                      : BorderRadius.circular(10),
                                ),
                                duration: const Duration(milliseconds: 300),
                                child: state is RegisterLoadingState
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Salvar',
                                        style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * .15,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
