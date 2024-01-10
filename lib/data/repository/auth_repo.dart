import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constaants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });


  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstant.LOGIN_URL, {
      "email": email,
      "password": password,
    });
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<String> getUserToken()async{
    return  sharedPreferences.getString(AppConstant.TOKEN)!;
  }

  bool userLoggedIn(){
    return  sharedPreferences.containsKey(AppConstant.TOKEN)!;
  }
}
