
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_tax_model.dart';
import '../../utils/app_constaants.dart';
import '../api/api_client.dart';

class UserTaxRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserTaxRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> setUserTaxData(UserTaxModel userTaxModel) async {
    return await apiClient.putData(AppConstant.USER_TAXES_URL, userTaxModelToJson(userTaxModel));
  }

  // Future<String> getUserToken()async{
  //   return  sharedPreferences.getString(AppConstant.TOKEN)!;
  // }
}
