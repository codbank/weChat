import 'package:fluro/fluro.dart';
import 'package:wechat/route/route.dart';

class Routes {
  static void initRoutes(Router router) {
    router.define("/login", handler: usersHandler);
    router.define("/home", handler: homeHandler);
    router.define("/register", handler: registerHandler);
  }
}
