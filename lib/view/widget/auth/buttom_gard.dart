import 'package:consultancy/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonGard extends StatelessWidget {
  final String textbutton;
  final void Function()? onPressed;
  const ButtonGard({Key? key, required this.textbutton, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Get.width * 0.4,
      child: MaterialButton(
        color: AppColors.primary,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(textbutton,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
