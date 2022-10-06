import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/modules/auth/login/change_password_page.dart';
import 'package:checkin_app/modules/auth/login/login_page.dart';
import 'package:checkin_app/modules/auth/register/register_page.dart';
import 'package:checkin_app/modules/checkin/scan_page.dart';
import 'package:checkin_app/modules/history_checkin/detail_history_checkin.dart';
import 'package:checkin_app/modules/history_checkin/infomation_event_page.dart';
import 'package:checkin_app/modules/home/create_checkin_page.dart';
import 'package:checkin_app/modules/home/event_more_page.dart';
import 'package:checkin_app/modules/home/home_admin/home_admin_page.dart';
import 'package:checkin_app/modules/home/home_admin/root_admin_home_page.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/home/root_home_page.dart';
import 'package:checkin_app/modules/notify/notification_detail_page.dart';
import 'package:checkin_app/modules/profile/profile_admin_page.dart';
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
      case RouteName.createEventPage:
        return PageTransition(
            child: const CreateEventPage(),
            type: PageTransitionType.bottomToTop);
      case RouteName.eventMorePage:
        return PageTransition(
            child: const EventMorePage(), type: PageTransitionType.bottomToTop);
      case RouteName.loginPage:
        return PageTransition(
            child: const LoginPage(), type: PageTransitionType.fade);
      case RouteName.register:
        return PageTransition(
            child: const Register(), type: PageTransitionType.fade);
      case RouteName.homePage:
        return PageTransition(
            child: const HomePage(), type: PageTransitionType.fade);
      case RouteName.homeAdminPage:
        return PageTransition(
            child: const HomeAdminPage(), type: PageTransitionType.fade);
      case RouteName.rootPage:
        return PageTransition(
            child: const RootPage(), type: PageTransitionType.fade);
      case RouteName.rootAdminPage:
        return PageTransition(
            child: const RootAdminPage(), type: PageTransitionType.fade);
      // case RouteName.notifacationPage:
      //   return MaterialPageRoute(builder: (_) => const NotificationPage());
      case RouteName.notifacationDetailPage:
        return PageTransition(
            child: const NotificationDetailPage(),
            type: PageTransitionType.fade);
      case RouteName.profilePage:
        return PageTransition(
            child: const ProfilePage(), type: PageTransitionType.fade);
      case RouteName.profileAdminPage:
        return PageTransition(
            child: const ProfileAdminPage(), type: PageTransitionType.fade);
      case RouteName.changePassword:
        return PageTransition(
            child: const ChangePasswordPage(), type: PageTransitionType.fade);
      case RouteName.detailHistoryCheckin:
        return PageTransition(
            child: DetailHistoryCheckin(
              idSuKien: (settings.arguments as DetailHistoryCheckinAr).idSuKien,
              tenSk: (settings.arguments as DetailHistoryCheckinAr).tenSk,
            ),
            type: PageTransitionType.fade);
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
