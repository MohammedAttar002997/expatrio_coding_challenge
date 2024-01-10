import 'package:get/get.dart';
import '../data/repository/auth_repo.dart';
import '../models/response_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;



  Future<ResponseModel> login(String email, String password) async {

    //showing loading icon until finish the login process
    _isLoading = true;

    //update the UI to show the loader
    update();

    //Connect with the login API
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["accessToken"]);
      responseModel = ResponseModel(response.body["accessToken"], true);
    } else {
      responseModel = ResponseModel(response.statusText!, false);
    }

    //Finished loading and updated the UI
    _isLoading = false;
    update();
    return responseModel;
  }

  //Check if the user is logged in or not
  bool userLoggedIn(){
    return  authRepo.userLoggedIn();
  }
}
