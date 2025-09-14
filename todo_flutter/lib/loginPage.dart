import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/dashboard.dart';
import 'package:todo_flutter/registration.dart';
import 'package:velocity_x/velocity_x.dart';

import 'appLogo.dart';
import 'config.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(
        Uri.parse(login),
        headers: {"Content-type":"application/json"},
        body: jsonEncode(reqBody),
      );

      print("response  ${response.body}");

      var data = jsonDecode(response.body);

      if(data['status']){
        var myToken = data['token'];

        prefs.setString('token', myToken);

        Get.to(()=>Dashboard(token: myToken));
      }else{
        Get.snackbar("Error", "Something went wrong");
      }

    }else{
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color(0XFFF95A3B),Color(0XFFF96713)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0,0.8],
                tileMode: TileMode.mirror
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonLogo(),
                  SizedBox(height: 20),
                  Text("Email Sign-In", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.yellow)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 4),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Invalid email address" : null,
                          hintText: "Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 4),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorText: _isNotValidate ? "Invalid Password" : null,
                          hintText: "Password ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      loginUser();
                    },
                    child: HStack([
                      VxBox(child: "LogIn".text.white.makeCentered().p16()).green600.roundedLg.make(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Get.to(Registration());
          },
          child: Container(
            height: 25,
            color: Colors.lightBlue,
            child: Center(child: Text("Create a new Account..! Sign Up",style: TextStyle(color: Colors.white),),),
          ),
        ),
      ),
    );
  }
}
