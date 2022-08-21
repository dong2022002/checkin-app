import 'package:checkin_app/modules/auth/login/login_page.dart';
import 'package:checkin_app/modules/auth/register/register_page.dart';
import 'package:checkin_app/modules/checkin/checkin_page.dart';
import 'package:checkin_app/modules/checkin/qr_scanner.dart';
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
      case RouteName.notifacationPage:
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case RouteName.notifacationDetailPage:
        return MaterialPageRoute(
            builder: (_) => const NotificationDetailPage());
      case RouteName.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteName.qrScanPage:
        return MaterialPageRoute(
            builder: (_) => QrScanner(
                  qrCode: settings.arguments as String,
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
