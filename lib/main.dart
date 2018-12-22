import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat/database/databaseLogin.dart';
import 'package:wechat/database/model/user.model.dart';
import 'package:wechat/home/home_page.dart';
import 'package:wechat/register/register_loading.dart';
import 'package:wechat/route/route_handle.dart';
import 'package:wechat/sign/index.dart';
import './route/application.dart';

void main() {
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootRoute();
  }
}

class RootRoute extends StatefulWidget {
  _RootRouteState createState() => _RootRouteState();
}

class _RootRouteState extends State<RootRoute> {
  _RootRouteState() {
    final router = new Router();
    Routes.initRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<UserPerson>>(
      future: DataBaseSigninProvider.db.getClinets(),
      builder:
          (BuildContext context, AsyncSnapshot<List<UserPerson>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'weChat',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: HomePage(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'weChat',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: Application.router.generator,
              home: LoginHomePage(),
            );
          }
        } else {
          return MaterialApp(
            home: RegisterLoading(),
          );
        }
      },
    );
  }
}
