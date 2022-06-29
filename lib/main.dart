import 'package:clean_app/bloc/booking_provider.dart';
import 'package:clean_app/bloc/search_staff_provider.dart';
import 'package:clean_app/bloc/staff_provider.dart';
import 'package:clean_app/bloc/user_provider.dart';
import 'package:clean_app/ui/screen/home_screen.dart';
import 'package:clean_app/ui/userPermission/login_page.dart';
import 'package:clean_app/ui/userPermission/user_login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/booked_record_provider.dart';

void main() {
  runApp(AppProviders(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CheckAuth(),
    );
  }
}



class AppProviders extends StatelessWidget {
  final Widget child;

  AppProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => SearchStaffProvider()),
          ChangeNotifierProvider(create: (context) => StaffProvider()),
          ChangeNotifierProvider(create: (context) => BookedRecordProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => BookingProvider()),
        ],
        child: child
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  late Future<bool> loginCheckFuture;

  @override
  void initState() {
    super.initState();
    loginCheckFuture = _checkIfLoggedIn();
  }

  Future<bool> _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    return FutureBuilder(
        future: loginCheckFuture,
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data == true){
              child = HomeScreen();
            } else {
              child = LoginPage();
            }
          } else{
            child = LoginPage();
          }
          return child;
        }
    );
  }
}