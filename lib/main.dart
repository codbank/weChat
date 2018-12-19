import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wechat/route/route_handle.dart';
import 'package:wechat/sign/index.dart';
import './route/application.dart';

void main() => runApp(MyApp());

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Application.router.generator,
        home: LoginHomePage());
  }
}
