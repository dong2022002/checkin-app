import 'package:flutter/material.dart';

class ImageAuth extends StatelessWidget {
  const ImageAuth({
    required this.pathImage,
    Key? key,
  }) : super(key: key);
  final String pathImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.09,
      height: size.height * 0.05,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(pathImage), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(12)),
    );
  }
}
