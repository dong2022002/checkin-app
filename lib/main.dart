import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:checkin_app/route/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => CheckinProvider())
        ],
        child: MaterialApp(
          initialRoute: RouteName.loginPage,
          // initialRoute: RouteName.qrScanPage,

          onGenerateRoute: router.Router.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            // change the focus border color of the TextField
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(primary: AppColors.kPrimaryColor),
            // change the focus border color when the errorText is set
            errorColor: Colors.red,
          ),
        ));
  }
}
