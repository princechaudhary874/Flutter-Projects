import 'package:dukaan/constants/consts.dart';
import 'package:dukaan/views/cart_screen/cart_screen.dart';
import 'package:dukaan/views/category_screen.dart/category_screen.dart';
import 'package:dukaan/views/home_screen/home_controller.dart';
import 'package:dukaan/views/home_screen/home_screen.dart';
import 'package:dukaan/views/profile_screen/profile_screen.dart';
import 'package:flutter/foundation.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // init home controller
    var controller = Get.put(HomeController());

    // creating list for bottom navigation bar items
    var navBarItems = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: category),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: acc),
    ];

    // list to show navbody
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value),
            ),
          ),
        ],
      ),

      // calling bottom navigation bar items
      bottomNavigationBar: Obx(
        //obx is used to get the value of the observable variable;
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          // type is used to show icon and name flexibly
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navBarItems,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
