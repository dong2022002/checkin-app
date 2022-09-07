import 'package:checkin_app/modules/auth/login/change_password_page.dart';
import 'package:checkin_app/modules/auth/login/login_page.dart';
import 'package:checkin_app/modules/auth/register/register_page.dart';
import 'package:checkin_app/modules/history_checkin/detail_history_checkin.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/notify/notification_detail_page.dart';
import 'package:checkin_app/modules/notify/notification_page.dart';
import 'package:checkin_app/modules/profile/profile_page.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class Router {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteName.homePage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomePage());
      case RouteName.historyCheckin:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HistoryCheckin());

      case RouteName.notifacationPage:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case RouteName.notifacationDetailPage:
        return MaterialPageRoute(
            builder: (_) => const NotificationDetailPage());
      case RouteName.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteName.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case RouteName.detailHistoryCheckin:
        return MaterialPageRoute(
            builder: (_) => DetailHistoryCheckin(
                  idSuKien: settings.arguments as int,
                ));
      default:
        {
          return MaterialPageRoute(
              builder: (_) => const Scaffold(
                    body: Center(child: Text("No routes match")),
                  ));
        }
    }
  }
}
