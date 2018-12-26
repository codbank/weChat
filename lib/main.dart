import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:wechat/database/database_auth.dart';
import 'package:wechat/database/model/auth.model.dart';
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
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLable = "flutter getRegistrationID: $rid";
      });
    });
    jpush.setup(
      appKey: "c4f4ddf94d1482353cf3d495",
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jpush.applyPushAuthority(
      new NotificationSettingsIOS(sound: false, alert: false, badge: false),
    );
    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          // print("flutter onReceiveNotification: $message");
          // setState(() {
          //     _platformVersion = "flutter onReceiveNotification: $message";
          //   });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          setState(() {
            debugLable = "flutter onOpenNotification: $message";
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      debugLable = platformVersion;
    });
  }

  _RootRouteState() {
    final router = new Router();
    Routes.initRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<AuthModel>>(
      future: DataBaseAuthProvider.db.getClinets(),
      builder: (BuildContext context, AsyncSnapshot<List<AuthModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'weChat',
              theme: ThemeData(primaryColor: Colors.grey[900]),
              home: HomePage(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'weChat',
              theme: ThemeData(
               primaryColor: Colors.grey[900]
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
