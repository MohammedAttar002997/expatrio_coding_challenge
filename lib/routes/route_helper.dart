
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../screens/auth/sign_in_page.dart';
import '../screens/home/user_tax_page.dart';

class RouteHelper {
  //Login Page
  static const String initial = "/";

  static String getInitial() => initial;

  //User Tax Page
  static const String taxPage = "/tax-page";

  static String getUserTaxes() => taxPage;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      //Check if the user is logged in or not before going to the next page
      page: () => (Get.find<AuthController>().userLoggedIn())
          ? const UserTaxPage()
          : const SignInPage(),
    ),
    GetPage(
      name: taxPage,
      page: () => const UserTaxPage(),
    ),
  ];
}
