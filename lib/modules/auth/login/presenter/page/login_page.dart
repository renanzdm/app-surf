import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_app/infrastructure/dependecy_injection/service_locator.dart';
import 'package:surf_app/modules/auth/login/domain/error/login_errors.dart';
import 'package:surf_app/modules/auth/login/presenter/cubit/login_cubit.dart';
import 'package:surf_app/modules/home/presenter/pages/home_page.dart';

import 'package:surf_app/shared/widgets/textfield_custom.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cubit = getIt.get<LoginCubit>();
  final _formKey = GlobalKey<FormState>();
  bool visiblePassword = true;
  @override
  void initState() {
    super.initState();
    cubit.stream.listen((state) {
      if (state is LoginErrorState) {
        BotToast.showNotification(
          title: (_) => Text('Erro ao logar usuario'),
          subtitle: (_) => state.error is LoginErrorInvalidUserOrPassword
              ? Text('Email ou senha estao errados')
              : Text('Tente novamente em instantes'),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 4),
          leading: (_) => Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
            size: 50,
          ),
        );
      } else if (state is LoginLoadedState) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        });
      }
    });
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
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * .1,
                    ),
                    Text(
                      'Entrar',
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
                      labelText: 'E-mail',
                      prefixIcon: Icons.mail_outline,
                      controller: cubit.emailController,
                      textInputType: TextInputType.emailAddress,
                      validator: cubit.validateEmail,
                    ),
                    TextFieldCustom(
                      labelText: 'Senha',
                      prefixIcon: Icons.lock_outline,
                      controller: cubit.passwordController,
                      obscureText: visiblePassword,
                      validator: cubit.validatePassword,
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
                    const SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.login();
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginState>(
                          bloc: cubit,
                          buildWhen: (previous, state) => previous != state,
                          builder: (_, state) {
                            return AnimatedContainer(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              height: 50,
                              width: state is LoginLoadingState
                                  ? 50
                                  : constraints.maxWidth * .65,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: state is LoginLoadingState
                                    ? BorderRadius.circular(32)
                                    : BorderRadius.circular(10),
                              ),
                              duration: const Duration(milliseconds: 300),
                              child: state is LoginLoadingState
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
                      height: constraints.maxHeight * .2,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
