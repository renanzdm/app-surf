import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_app/modules/auth/auth_page.dart';
import 'package:surf_app/modules/home/presenter/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      SharedPreferences _preferences;
      _preferences = await SharedPreferences.getInstance();
      var token = _preferences.containsKey('token-user');
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => token ? HomePage() : AuthPage(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        height: size.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 4,
                    image: AssetImage('assets/images/surfing.png'),
                  ),
                ),
              ),
            ),
            Text(
              'Points'.toUpperCase(),
              style: TextStyle(fontFamily: 'Roboto', fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 2),
              child: Text(
                'Wave'.toUpperCase(),
                style:
                    TextStyle(fontFamily: 'Roboto', color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
