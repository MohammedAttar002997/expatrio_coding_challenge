import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    //Validation of the user input
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty || !GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty || password.length < 6) {
        showCustomSnackBar("Password can' be less than 6 characters",
            title: "Password");
      } else {
        showCustomSnackBar(
          "All went well",
          title: "Perfect",
          isError: false
        );

        authController.login(email, password).then(
          (status) {
            if (status.isSuccess) {
              Get.toNamed(RouteHelper.getUserTaxes());
            } else {
              showCustomSnackBar(status.message);
            }
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    //welcome
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                      ),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                              fontSize:
                                  Dimensions.font20 * 3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Sign into your account",
                            style: TextStyle(
                              fontSize: Dimensions.font20,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    ),
                    //email
                    AppTextField(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //password
                    AppTextField(
                      isObscure: true,
                      textController: passwordController,
                      hintText: "Password",
                      icon: Icons.password_sharp,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //tag line

                    SizedBox(
                      height: Dimensions.screenHeight * 0.02,
                    ),
                    //sign in button
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                        height: Dimensions.screenHeight / 17,
                        width: Dimensions.screenWidth ,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius30,
                          ),
                          color: AppColor.mainColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: "LOGIN",
                            color: Colors.white,
                            size: Dimensions.font20 ,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    Lottie.asset("assets/login-background.json"),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.02,
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
