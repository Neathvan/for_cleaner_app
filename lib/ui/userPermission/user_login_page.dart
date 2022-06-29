import 'package:flutter/material.dart';
import 'package:clean_app/bloc/user_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/screen/home_screen.dart';
import 'package:clean_app/ui/userPermission/register_page.dart';
import 'package:clean_app/ui/widget/component/loading_screen.dart';
import 'package:provider/provider.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({Key? key}) : super(key: key);

  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    context.watch<UserProvider>().notmatch ? Container(alignment: Alignment.bottomLeft ,child: Text("Please again", style: TextStyle(color: Colors.red, fontSize: 15),),) : Container(),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the password';
                            } else if (value.length <= 6) {
                              return 'Password must be greator than 6 digits';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     padding: EdgeInsets.zero,
                        //   ),
                        //   onPressed: () {
                        //     Navigator.pushNamed(context, 'forgot');
                        //   },
                        //   child: Text(
                        //     'Forgot password?',
                        //     style: TextStyle(color: Colors.black),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
