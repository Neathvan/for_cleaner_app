import 'package:flutter/material.dart';
import 'package:clean_app/bloc/KProvider.dart';
import 'package:clean_app/model/auth/login_user_infor.dart';
import 'package:clean_app/model/register.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/model/user_model.dart';
import 'package:clean_app/repository/auth/user_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/service/kresult.dart';
import 'package:clean_app/ui/userPermission/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends KProvider {
  UserRepository userRepository = UserRepository();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? gender;
  String? nationality;

  void updateGender(int genderId){
    genderId != 0 ? gender = 'female' : gender = 'male';
    update();
  }

  void updateNationality(int national){
    national != 0 ? nationality = 'khmer' : nationality = 'foreigner';
    update();
  }

  KResult<LoginUserInfor> loginUserInfor  = KResult(ApiStatus.empty, {});
  KResult<LoginUserInfor> registerResult  = KResult(ApiStatus.empty, {});
  KResult<UserModel> userResult             = KResult(ApiStatus.empty, {});
  bool notmatch = false;
  Future<ApiStatus?> login(BuildContext context, String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    loginUserInfor.status = ApiStatus.loading;
    showLoading(context, 'Loading ....');
    KData data = await userRepository.login(email, password);
    loginUserInfor.status = data.status;

    if( data.status == ApiStatus.loaded ) {
      prefs.setString('token', LoginUserInfor.fromJson(data.response.data).token);
      prefs.setString('userName', LoginUserInfor.fromJson(data.response.data).name);
      hideLoading(context);
      notmatch = false;
      update();
      return loginUserInfor.status;
    }

    notmatch = true;
    hideLoading(context);
    update();
    return loginUserInfor.status;
  }

  Future<ApiStatus?> register(String name, String email, String password, String repwd) async {
    registerResult.status = ApiStatus.loading;

    KData data = await userRepository.register(name, email, password, repwd);
    registerResult.status = data.status;

    if( data.status == ApiStatus.loaded ) {
      // prefs.setString('token', LoginUserInfor.fromJson(data.response.data).token);
    }

    update();
    return registerResult.status;
  }

  Future<ApiStatus?> logout( BuildContext context) async {
    final SharedPreferences prefs = await _prefs;

    // prefs.remove("token");
    KData data = await userRepository.logout(prefs.get("token").toString());

    if( data.status == ApiStatus.loaded ) {
      prefs.remove('token');

      return  Navigator.pushReplacement (
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    update();
  }

  Future<ApiStatus?> getUserInformation( BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    userResult.status = ApiStatus.loading;

    KData data = await userRepository.getUserInformation(prefs.get("token").toString());

    userResult.status = data.status;
    if( data.status == ApiStatus.loaded ) {
     userResult.data    = UserModel.fromJson(data.response.data);
     update();
    }
    update();
  }
}
