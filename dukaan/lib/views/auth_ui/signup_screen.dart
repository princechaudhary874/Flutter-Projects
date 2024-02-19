import 'package:dukaan/common_widgets/applogo_widgets.dart';
import 'package:dukaan/common_widgets/bg_widget.dart';
import 'package:dukaan/common_widgets/custom_textfield.dart';
import 'package:dukaan/common_widgets/our_buttons.dart';
import 'package:dukaan/constants/consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      // to remove overflow error we make resizeToAvoidBottomInset false
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // giving 10 percent space from top
              (context.screenHeight * 0.1).heightBox,
              // logo of the app
              applogoWidget(),
              10.heightBox,
              "Sign Up to $appname".text.fontFamily(bold).white.size(20).make(),
              10.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name textfield
                  customTextField(title: name, hint: nameHint),
                  // email textfield
                  customTextField(title: email, hint: emailHint),
                  // password textfield
                  customTextField(title: password, hint: passwordHint),
                  // confirm password
                  customTextField(title: confirmpass, hint: passwordHint),

                  5.heightBox,

                  // terms and conditions
                  Row(
                    children: [
                      Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: privacypolic,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                  10.heightBox,

                  // Sign Up button
                  ourButton(
                    onPress: () {},
                    color: (isCheck == true) ? redColor : lightGrey,
                    textColor: whiteColor,
                    title: signUp,
                  ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  // login in to your old account
                  alreadyAcc.text.color(fontGrey).makeCentered(),
                  // create login button
                  5.heightBox,
                  ourButton(
                    onPress: () {
                      // navigate to loign page
                      Get.back();
                    },
                    color: lightGolden,
                    textColor: whiteColor,
                    title: logIn,
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
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
      ),
    ));
  }
}
