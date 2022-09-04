import 'package:firebase_app/home/food_page_body.dart';
import 'package:firebase_app/widgets/big_text.dart';
import 'package:firebase_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/utils/colors.dart';

// >> widget holding header and body section of the home page
class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // upper body of the application
    return Scaffold(
      // >> wrapping with a column so the buttons and widgets start from the top
      body: Column(
        children: [
          // >> upper search bar
          Container(
            // spacing out between the bar and other components
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // >> the country/city selector
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "United Arab Emirates",
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(text: "Ajman", color: Colors.black54),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                // >> Search button
                Center(
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          // >> the sliding panel page
          FoodPageBody()
        ],
      ),
    );
  }
}
