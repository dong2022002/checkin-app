import 'package:checkin_app/components/notifycation_detail_component/header_text_detail.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class InfomationEventPage extends StatelessWidget {
  const InfomationEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 26),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderTextDeTail(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit '),
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 24),
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/image_demo.jpeg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                  style: AppStyles.h5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
