import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_app/utils/colors.dart';
import 'package:firebase_app/utils/diamentions.dart';
import 'package:firebase_app/widgets/big_text.dart';
import 'package:firebase_app/widgets/icon_and_text_widget.dart';
import 'package:firebase_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

// >> the upper body of the home page
// displaying the left and right scrolling food
class _FoodPageBodyState extends State<FoodPageBody> {
  // >> a page view controller
  // >> the little next slide on the right and left
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;
  final double _scaleFactor = 0.8; // 80% of the panel original size
  final double _height = Diamensions.pageViewContainer; // size of the panel

  // >> getting the page value
  @override
  void initState() {
    super.initState();
    // attaching a listener to check when we go left and right
    pageController.addListener(() {
      setState(() {
        // getting the page value
        // and adding a null checker
        _currPageValue = pageController.page!;
      });
    });
  }

  // >> disposing page value
  // so that when we leave the page the value wont be used (mem leak)
  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Diamensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        // the dot indicator below the panels
        DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }

  // >> builder for a single page item
  Widget _buildPageItem(int index) {
    // used for scaling item widgets when going left or right
    // scaling up and down the Y axis
    Matrix4 matrix = Matrix4.identity();

    // >> controling the scaling of the panels
    // >> the panel in the center
    if (index == _currPageValue.floor()) {
      // if it is the panel we are at
      // when page value & page index are equal then we get a page scaling of 1
      // so the original size
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      // passing size & position scaling parameter to the matrix
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    // >> the panel the motion is moving into
    else if (index == _currPageValue.floor() + 1) {
      // for scaling smoothness/control
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    // >> the panel the motion is moving away from
    else if (index == _currPageValue.floor() - 1) {
      // for scaling smoothness/control
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      // default panel size (to avoid size glitching)
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    // widget used to control the size of the panels through the matrix
    return Transform(
      transform: matrix,
      // wrapping in a stack for the height to take effect
      child: Stack(
        children: [
          // the image container
          Container(
            height: _height, // height of a single panel
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Diamensions.radius30),
              // switching between color depending on panel index
              color: index.isEven
                  ? const Color(0xFF69c5df)
                  : const Color(0xFF9294cc),
              // the food image
              image: const DecorationImage(
                fit: BoxFit.cover, // so the image will fit the whole box
                image: AssetImage("assets/image/food1.jpg"),
              ),
            ),
          ),
          // The white box containing the information
          Align(
            // pushes the widget to the bottom of the parent
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Diamensions.pageViewTextContainer,
              // bottom margin to control alignment
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Diamensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                ],
              ),
              // the stuff inside the white box
              child: Container(
                // just for the padding
                padding: EdgeInsets.only(
                    left: 15, top: Diamensions.height15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // >> line 1: the box title
                    BigText(text: "Fruits & Vegs"),
                    SizedBox(height: Diamensions.height10),
                    // >> line 2: stars and comment count
                    Row(
                      children: [
                        // used to draw things repeatedly horizontally
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: 15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SmallText(text: "4.5"),
                        const SizedBox(width: 10),
                        SmallText(text: "1287 comments")
                      ],
                    ),
                    SizedBox(height: Diamensions.height20),
                    // >> line 3: icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7Km",
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
