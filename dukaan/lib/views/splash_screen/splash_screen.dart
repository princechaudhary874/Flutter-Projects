import 'package:dukaan/common_widgets/applogo_widgets.dart';
import 'package:dukaan/constants/consts.dart';
import 'package:dukaan/views/auth_ui/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Call the changeScreen method after a delay
    Future.delayed(const Duration(seconds: 3), changeScreen);
  }

  // Creating a function to change screen
  void changeScreen() {
    // Navigate to LoginScreen using Get.to
    Get.to(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(24).white.make(),
            5.heightBox,
            appversion.text.size(14).white.make(),
            const Spacer(),
            credits.text.fontFamily(semibold).white.make()
          ],
        ),
      ),
    );
  }
}
