import 'dart:async';
import 'package:bluestack_assignment/data/datbase_provider.dart';
import 'package:bluestack_assignment/model/user_modal.dart';
import 'package:bluestack_assignment/model/validation_status.dart';
import 'package:bluestack_assignment/res.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppUtill.dart';

enum Event { LOGIN }

class LoginBloc {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ValidationStatus _validationStatus = ValidationStatus();
  String _userName="";
  String _passWord="";
  final _userNameStreamController=StreamController<String>();
  final _passwordStreamController=StreamController<String>();
  final _eventStreamController=StreamController<Event>();
  final _validationStreamController=StreamController<ValidationStatus>();
  final _loginStreamController=StreamController<bool?>();
  StreamSink<String> get userNameSink =>_userNameStreamController.sink;
  Stream<String> get userNameStream =>_userNameStreamController.stream;
  StreamSink<String> get passwordSink =>_passwordStreamController.sink;
  Stream<String> get passwordStream =>_passwordStreamController.stream;
  StreamSink<Event> get eventSink =>_eventStreamController.sink;
  Stream<Event> get eventStream =>_eventStreamController.stream;
  StreamSink<ValidationStatus> get validationSink =>_validationStreamController.sink;
  Stream<ValidationStatus> get validationStream =>_validationStreamController.stream;
  StreamSink<bool?> get loginSink =>_loginStreamController.sink;
  Stream<bool?> get loginStream =>_loginStreamController.stream;


  LoginBloc()
  {

    initUser();

    userNameStream.listen((value) {
      _userName=value.toString();
      AppUtill.printAppLog("value::${value.toString()}");
      _validateFormData();
    });

    passwordStream.listen((value) {
      _passWord=value.toString();
      AppUtill.printAppLog("value::${value.toString()}");
      _validateFormData();
    });

    eventStream.listen((value) {
      AppUtill.printAppLog("value::${value.toString()}");
      // AppUtill.printAppLog("value::${doLogin()}");
      // doLogin();
      _doLogin((isLogedin) => {loginSink.add(isLogedin)});

    });

  }

  _validateFormData(){
    if(_userName.length>=3&&_userName.length<=10){
      // _validationStatus.isUserNameValid=true;
      _validationStatus.usernameStatus=Status.VALID;
    }else if(_userName.length==0){
      _validationStatus.usernameStatus=Status.NONE;
    }else{
      _validationStatus.usernameStatus=Status.ERROR;
    }
    if(_passWord.length>=3&&_passWord.length<=10){
      _validationStatus.passwordStatus=Status.VALID;
    }else if(_passWord.length==0){
      _validationStatus.passwordStatus=Status.NONE;
    }else{
      _validationStatus.passwordStatus=Status.ERROR;
    }
    if(_validationStatus.usernameStatus==Status.VALID && _validationStatus.passwordStatus==Status.VALID)
      {
        _validationStatus.bothStatus=Status.VALID;
      }else{
      _validationStatus.bothStatus=Status.ERROR;
    }

    // AppUtill.printAppLog("value :: ${validationStatus.isUserNameValid}");

    validationSink.add(_validationStatus);

  }

  dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _eventStreamController.close();
    _validationStreamController.close();
    _loginStreamController.close();
  }

  bool? _doLogin(inner(bool isLogedin)) {

    // AppUtill.printAppLog("users : ${DBProvider.db.getUsers()}");

    DBProvider.db.loginUser(_userName, _passWord, (loginId) {

      if(loginId>0)
      {
        _prefs.then((SharedPreferences prefs) {
          prefs.setBool(Keys.IS_LOGIN, true);
          prefs.setInt(Keys.USER, loginId);
        });
        return inner(true);
      }else{
        return inner(false);
      }

    });




    // AppData _appData = AppData();
    // if(_appData.loginData.containsKey(_userName))
    //   {
    //     if(_appData.loginData[_userName]==_passWord)
    //       {
    //
    //         _prefs.then((SharedPreferences prefs) {
    //           prefs.setBool(Keys.IS_LOGIN, true);
    //           prefs.setString(Keys.USER, _userName);
    //         });
    //
    //         // AppPrefs.getInstance().setLogin();
    //         // AppPrefs.getInstance().setStringData("username", userName);
    //         return true;
    //       }else{
    //       return false;
    //     }
    //   }else{
    //   return false;
    // }
  }

  void initUser() {
    DBProvider.db.isExistUser("9898989898", (isExist) => {
      if(!isExist){
        DBProvider.db.createUser(new User(id: 1, user_name: "9898989898", password: "password12", name: "Rajnish Kumar", profile_pic: Res.user_9898989898, rating: 3055, tournament_played: 45, tournament_won: 40))
      }
    });

    DBProvider.db.isExistUser("9876543210", (isExist) => {
      if(!isExist){
        DBProvider.db.createUser(new User(id: 2, user_name: "9876543210", password: "password12", name: "Simon Baker", profile_pic: Res.user_9876543210, rating: 2250, tournament_played: 34, tournament_won: 12))
      }
    });



  }



}
