import 'package:get/get.dart';

import '../data/repository/user_tax_repo.dart';
import '../models/response_model.dart';
import '../models/user_tax_model.dart';

class UserTaxController extends GetxController {
  final UserTaxRepo userTaxRepo;

  UserTaxController({
    required this.userTaxRepo,
  });

  //Counter value to add a TID number matching the value of the counter
  int _counter = 3;

  int get counter => _counter;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> setUserTaxes(UserTaxModel userTaxModel) async {
    _isLoading = true;
    update();
    Response response = await userTaxRepo.setUserTaxData(userTaxModel);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      // userTaxRepo.getUserToken();
      responseModel = ResponseModel(response.statusText!, true);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  //Edit the value of the counter each time the user want to add a new TID number.
  void increaseCounterValue(){
    _counter++;
    update();
  }
}
