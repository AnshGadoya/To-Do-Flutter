import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_flutter/appLogo.dart';
import 'package:todo_flutter/config.dart';
import 'package:velocity_x/velocity_x.dart';

import 'loginPage.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  Future<void> registerUser() async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){

      var reqBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(
          Uri.parse(registration),
        headers: {"Content-type":"application/json"},
        body: jsonEncode(reqBody),
      );

      print("response  ${response.body}");

      if(response.statusCode == 200){
        Get.to(SignInPage());
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
                  Text("CREATE YOUR ACCOUNT", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.yellow)),
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
                        suffixIcon: IconButton(icon: Icon(Icons.copy),onPressed: (){
                          final data = ClipboardData(text: passwordController.text);
                          Clipboard.setData(data);
                        },),
                          prefixIcon: IconButton(icon: Icon(Icons.password),onPressed: (){
                            String passGen =  generatePassword();
                            passwordController.text = passGen;
                            setState(() {
                            });
                          },),
                          filled: true,
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Invalid Password" : null,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                      ),
                    ),
                  ),
                  HStack([
                    GestureDetector(
                      onTap: ()=>{ registerUser() },
                      child: VxBox(
                          child: "Register".text.white.makeCentered().p16()
                      ).green600.roundedLg.make().px16().py16(),
                    ),
                  ]),
                  GestureDetector(
                    onTap: (){
                      print("Sign In");
                      Get.to(()=>SignInPage());
                    },
                    child: HStack([
                      "Already Registered?".text.make(),
                      " Sign In".text.white.make()
                    ]).centered(),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String generatePassword() {
  return '';
}
