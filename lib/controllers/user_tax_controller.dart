import 'package:flutterexpatriocodingchallenge/shared/countries_constants.dart';
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
  int _counter = 1;

  int get counter => _counter;
  Map<String, dynamic> _num = Map<String, dynamic>();

  Map<String, dynamic> get num => _num;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isChecked = false;

  bool get isChecked => _isChecked;

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

  set setNumValue(Map<String, dynamic> numMap) {
    _num = numMap;
  }

  //Edit the value of the counter each time the user want to add a new TID number.
  void increaseCounterValue() {
    _counter++;
    update();
  }

  void decreaseCounterValue() {
    _counter--;
    update();
  }

  void changeStatus(bool value){
    _isChecked=value;
    update();
  }
}
