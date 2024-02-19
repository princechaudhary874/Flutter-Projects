import 'package:dukaan/common_widgets/home_buttons.dart';
import 'package:dukaan/constants/consts.dart';
import 'package:dukaan/constants/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchAny,
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 150,
                      itemCount: sliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          sliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),
                  10.heightBox,
                  // Deals buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2,
                      (index) => homeButtons(
                        height: context.screenHeight * .15,
                        width: context.screenWidth / 2.5,
                        icon: (index == 0) ? icTodaysDeal : icFlashDeal,
                        title: (index == 0) ? todayDeal : flashSale,
                      ),
                    ),
                  ),
                  10.heightBox,

                  // second vxswiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 150,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      }),

                  10.heightBox,

                  // top deals
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => homeButtons(
                        height: context.screenHeight * .15,
                        width: context.screenWidth / 3.5,
                        icon: (index == 0)
                            ? icTopCategories
                            : (index == 1)
                                ? icBrands
                                : icTopSeller,
                        title: (index == 0)
                            ? topCategories
                            : (index == 1)
                                ? brand
                                : topSeller,
                      ),
                    ),
                  ),
                  15.heightBox,

                  // featured categories
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .size(18)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  ),
                  15.heightBox
  

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
