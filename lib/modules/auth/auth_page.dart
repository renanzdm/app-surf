import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surf_app/modules/auth/login/presenter/page/login_page.dart';
import 'package:surf_app/modules/auth/register/presenter/page/register_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: sizes.height,
        width: sizes.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: AssetImage(
              'assets/images/3.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: sizes.height * .1,
            ),
            Text(
              'Encontre as melhoras ondas',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              'WavePoints.',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: sizes.height * .35,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                height: 50,
                width: sizes.width * .65,
                alignment: Alignment.center,
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              // ignore: lines_longer_than_80_chars
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => RegisterPage()));
              },
              child: Container(
                height: 50,
                width: sizes.width * .65,
                alignment: Alignment.center,
                child: Text(
                  'Criar Conta',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
