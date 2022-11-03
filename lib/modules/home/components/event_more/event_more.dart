import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class EventMore extends StatelessWidget {
  const EventMore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteName.eventMorePage);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.trending_flat,
                  color: const Color(0xff0B4619).withOpacity(.6),
                ),
              ),
              Text(
                'Các sự kiện tham gia khác chi đoàn',
                style: AppStyles.h5.copyWith(
                  color: const Color(0xff0B4619).withOpacity(.7),
                ),
                textAlign: TextAlign.right,
              ),
            ],
          )),
    );
  }
}
