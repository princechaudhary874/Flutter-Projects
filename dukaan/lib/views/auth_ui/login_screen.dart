import 'package:dukaan/common_widgets/applogo_widgets.dart';
import 'package:dukaan/common_widgets/bg_widget.dart';
import 'package:dukaan/common_widgets/custom_textfield.dart';
import 'package:dukaan/common_widgets/our_buttons.dart';
import 'package:dukaan/constants/consts.dart';
import 'package:dukaan/constants/list.dart';
import 'package:dukaan/views/auth_ui/signup_screen.dart';
import 'package:dukaan/views/home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      // to remove overflow error we make resizeToAvoidBottomInset false
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            // giving 10 percent space from top
            (context.screenHeight * 0.1).heightBox,
            // logo of the app
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(20).make(),
            10.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // email textfield
                customTextField(title: email, hint: emailHint),
                // password textfield
                customTextField(title: password, hint: passwordHint),
                // forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetPass.text.make(),
                  ),
                ),
                5.heightBox,
                // Log In button
                ourButton(
                  onPress: () {
                    Get.to(() => const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: logIn,
                ).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                // create new account
                createNew.text.color(fontGrey).makeCentered(),
                // create sign up button
                5.heightBox,
                ourButton(
                  onPress: () {
                    // navigate to sign up page
                    Get.to(() => const SignUpScreen());
                  },
                  color: lightGolden,
                  textColor: whiteColor,
                  title: signUp,
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                logWith.text.color(fontGrey).makeCentered(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(
                          socialIconlist[index],
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
                .box
                .white
                .rounded
                .p16
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ],
        ),
      ),
    ));
  }
}
