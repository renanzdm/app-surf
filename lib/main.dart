import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as _dotenv;

import 'infrastructure/dependecy_injection/service_locator.dart';
import 'modules/splash/splash_page.dart';
import 'shared/utils/navigator_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _dotenv.load(fileName: ".env");
  configureDependencies();
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: BotToastInit(),
      navigatorKey: NavigatorKey.navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}
