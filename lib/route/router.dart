import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/modules/auth/login/change_password_page.dart';
import 'package:checkin_app/modules/auth/login/login_page.dart';
import 'package:checkin_app/modules/auth/register/register_page.dart';
import 'package:checkin_app/modules/checkin/scan_page.dart';
import 'package:checkin_app/modules/history_checkin/detail_history_checkin.dart';
import 'package:checkin_app/modules/history_checkin/infomation_event_page.dart';
import 'package:checkin_app/modules/home/event_more_page.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/home/root_home_page.dart';
import 'package:checkin_app/modules/notify/notification_detail_page.dart';
import 'package:checkin_app/modules/profile/profile_page.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Router {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.informationEventPage:
        return PageTransition(
            child: InfomationEventPage(
              tenNhomSK:
                  (settings.arguments as InfomationEventPageAr).tenNhomSK,
              event: (settings.arguments as InfomationEventPageAr).event,
            ),
            type: PageTransitionType.fade);
      case RouteName.qrScanPage:
        return PageTransition(
            child: const ScanPage(), type: PageTransitionType.bottomToTop);
      case RouteName.eventMorePage:
        return PageTransition(
            child: const EventMorePage(), type: PageTransitionType.bottomToTop);
      case RouteName.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteName.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteName.homePage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomePage());

      case RouteName.rootPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RootPage());
      // case RouteName.notifacationPage:
      //   return MaterialPageRoute(builder: (_) => const NotificationPage());
      case RouteName.notifacationDetailPage:
        return MaterialPageRoute(
            builder: (_) => const NotificationDetailPage());
      case RouteName.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteName.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case RouteName.detailHistoryCheckin:
        return MaterialPageRoute(builder: (_) {
          DetailHistoryCheckinAr argument =
              settings.arguments as DetailHistoryCheckinAr;
          return DetailHistoryCheckin(
            idSuKien: argument.idSuKien,
            tenSk: argument.tenSk,
          );
        });
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

class DetailHistoryCheckinAr {
  late int idSuKien;
  late String tenSk;
  DetailHistoryCheckinAr(this.idSuKien, this.tenSk);
}

class InfomationEventPageAr {
  late String tenNhomSK;
  late Event event;
  InfomationEventPageAr(this.tenNhomSK, this.event);
}
