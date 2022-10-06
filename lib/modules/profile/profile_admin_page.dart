import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/profile/components/info_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileAdminPage extends StatelessWidget {
  const ProfileAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(builder: (context, user, child) {
      return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${user.admin?.nickName}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        InfoItem(
                          text: '${user.admin?.nickName}',
                          title: 'chi đoàn',
                          icon: Icons.person,
                        ),
                        InfoItem(
                          text: '${user.admin?.email}',
                          title: 'Email',
                          icon: Icons.email,
                        ),
                        InfoItem(
                          text: '${user.admin?.phone}',
                          title: 'Số điện thoại',
                          icon: Icons.phone,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: size.height * 0.075,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.black26.withOpacity(.6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    'Đăng xuất',
                                    style: AppStyles.h6.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          AppColors.kTextColor.withOpacity(.75),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
