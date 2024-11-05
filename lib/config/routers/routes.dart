import 'package:flutter/cupertino.dart';
import 'package:personal_financial_management/core/screens/error_screen.dart';
import 'package:personal_financial_management/core/screens/home_screen.dart';
import 'package:personal_financial_management/features/add/presentation/screens/add_screen.dart';
import 'package:personal_financial_management/features/auth/presentation/screens/profile_screen.dart';
import 'package:personal_financial_management/features/budget/presentation/screens/budget_screen.dart';
import 'package:personal_financial_management/features/over/presentation/screens/over_screen.dart';
import 'package:personal_financial_management/features/transaction_book/presentation/screens/transaction_book_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return _cupertinoRoute(
          const HomeScreen(),
        );
      case ProfileScreen.routeName:
        return _cupertinoRoute(
          ProfileScreen(),
        );
      case BudgetScreen.routeName:
        return _cupertinoRoute(
          BudgetScreen(),
        );
      case AddScreen.routeName:
        return _cupertinoRoute(
          AddScreen(),
        );
      case OverScreen.routeName:
        return _cupertinoRoute(
          OverScreen(),
        );
      case TransactionBookScreen.routeName:
        return _cupertinoRoute(
          TransactionBookScreen(),
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
