import 'package:firebase_app/utils/colors.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  String name;
  String? subText;
  String type;
  double distance;
  int duration;

  FoodItem(
      {super.key,
      required this.name,
      this.subText,
      required this.type,
      required this.distance,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.mainColor,
          ),
        ),
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width - 130,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 5)),
            ],
          ),
          child: const Text("test"),
        ),
      ],
    );
  }
}
