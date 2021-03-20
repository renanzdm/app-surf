import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_app/infrastructure/dependecy_injection/service_locator.dart';
import 'package:surf_app/modules/auth/auth_page.dart';
import 'package:surf_app/modules/home/presenter/cubit/home_cubit.dart';
import 'package:surf_app/infrastructure/extensions/capitalize.dart';
import 'package:surf_app/modules/home/presenter/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit cubit = getIt.get<HomeCubit>();
  final snackBar = SnackBar(
    content: Text('Opps...ocorreu um erro realize o login novamente'),
    backgroundColor: Colors.red,
  );

  @override
  void initState() {
    cubit.getUserInfo();
    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        cubit.stream.listen((state) {
          if (state is HomeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(const Duration(milliseconds: 4500), () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AuthPage()),
                (route) => false,
              );
            });
          }
        });
      },
    );

    super.initState();
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
        gradient: LinearGradient(
          colors: [
            Color(0xff004683),
            Color(0xff009FCD),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (_, constraints) {
            return Container(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is HomeErrorState) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  } else if (state is HomeLoadedState) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight * 0.05,
                          ),
                          Text(
                            'Bem Vindo ',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Busque as mais belas e melhores praias para surfar',
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w100,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SearchField(
                            width: constraints.maxWidth,
                          )
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
