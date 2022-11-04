import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/models/nhomSuKien.dart';
import 'package:checkin_app/modules/auth/login/change_password_page.dart';
import 'package:checkin_app/modules/auth/login/login_page.dart';
import 'package:checkin_app/modules/auth/register/register_page.dart';
import 'package:checkin_app/modules/checkin/scan_page.dart';
import 'package:checkin_app/modules/history_checkin/admin_list_history_page.dart';
import 'package:checkin_app/modules/history_checkin/detail_history_checkin.dart';
import 'package:checkin_app/modules/history_checkin/infomation_event_page.dart';
import 'package:checkin_app/modules/home/components/event_category/event_category.dart';
import 'package:checkin_app/modules/home/event_more_page.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/home/root_home_page.dart';
import 'package:checkin_app/modules/home_admin/components/create_checkin_page.dart';
import 'package:checkin_app/modules/home_admin/home_admin_page.dart';
import 'package:checkin_app/modules/home_admin/root_admin_home_page.dart';
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
      case RouteName.adminListHistoryPage:
        return PageTransition(
            child: AdminListHistoryPage(
              lanDiemDanh:
                  (settings.arguments as AdminListHistoryPageAR).lanDiemDanh,
              dsDiemDanhTrongChiDoan:
                  (settings.arguments as AdminListHistoryPageAR).dsIn,
              dsDiemDanhKhacChiDoan:
                  (settings.arguments as AdminListHistoryPageAR).dsOut,
              isInCheckin:
                  (settings.arguments as AdminListHistoryPageAR).isInCheckin,
            ),
            type: PageTransitionType.fade);
      case RouteName.createEventPage:
        return PageTransition(
            child: CreateEventPage(
              dsNhomSuKien: settings.arguments as List<NhomSuKien>,
            ),
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
              isAdmin: (settings.arguments as DetailHistoryCheckinAr).isAdmin,
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
  late bool isAdmin;
  DetailHistoryCheckinAr(this.idSuKien, this.tenSk, this.isAdmin);
}

class InfomationEventPageAr {
  late String tenNhomSK;
  late Event event;
  InfomationEventPageAr(this.tenNhomSK, this.event);
}

class AdminListHistoryPageAR {
  late int lanDiemDanh;
  late List<Checkin> dsIn;
  late List<Checkin> dsOut;
  late bool isInCheckin;
  AdminListHistoryPageAR(
      this.lanDiemDanh, this.dsIn, this.dsOut, this.isInCheckin);
}
