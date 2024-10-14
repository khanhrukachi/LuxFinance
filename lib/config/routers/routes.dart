import 'package:flutter/cupertino.dart';
import 'package:personal_financial_management/core/screens/error_screen.dart';
import 'package:personal_financial_management/core/screens/home_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return _cupertinoRoute(
          HomeScreen(),
        );


      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
    builder: (_) => view,
  );

  Routes._();
}
