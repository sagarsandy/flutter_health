import 'package:flutter/material.dart';
import 'package:flutter_health/screens/login_screen.dart';
import 'package:flutter_health/services/dart/network_api_service.dart';
import 'package:flutter_health/widgets/normal_text_widget.dart';
import 'package:flutter_health/widgets/round_rect_button_widget.dart';
import 'package:flutter_health/widgets/textfield_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameTEC = TextEditingController();
  final TextEditingController phoneNumberTEC = TextEditingController();
  final TextEditingController passportTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showPassport = true;
  bool showLoader = false;
  String passportTECHintText = "Passport No.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 550,
            color: Color(0XFF1A2450),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 70, height: 70),
                  Text(
                    "SELF-QUARANTINE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldWidget(
                              textEditingController: fullNameTEC,
                              hintText: "Full Name",
                              icon: Icons.person,
                              validateFieldValue: (String value) {
                                if (value.length < 3) {
                                  return "Minimum 3 characters required";
                                }
                              },
                            ),
                            SizedBox(height: 15),
                            TextFieldWidget(
                              textEditingController: phoneNumberTEC,
                              hintText: "Mobile No.",
                              icon: Icons.phone_iphone,
                              validateFieldValue: (String value) {
                                if (value.length < 10) {
                                  return "Minimum 10 characters required";
                                }
                                if (!value.contains(
                                    new RegExp('(?:[+0]9)?[0-9]{10}'))) {
                                  return "Only numbers are allowed";
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPassport = false;
                                        passportTECHintText = "Emirates ID";
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          color: showPassport
                                              ? Colors.transparent
                                              : Colors.blue),
                                      child: Text(
                                        "Emirates ID",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPassport = true;
                                        passportTECHintText = "Passport No.";
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          color: showPassport
                                              ? Colors.blue
                                              : Colors.transparent),
                                      child: Text(
                                        "Passport No.",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextFieldWidget(
                              textEditingController: passportTEC,
                              hintText: passportTECHintText,
                              icon: Icons.chrome_reader_mode_outlined,
                              validateFieldValue: (String value) {
                                if (value.length < 3) {
                                  return "Should be greater than 3 characters";
                                }
                              },
                            ),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                      RoundRectButtonWidget(
                        title: "Register",
                        gestureCallBack: () {
                          print("register called");
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            setState(() {
                              showLoader = true;
                            });
                            Future.delayed(const Duration(seconds: 3),
                                () => registerUser());
                          }
                        },
                      ),
                      SizedBox(height: 5),
                      if (showLoader)
                        ScalingText(
                          "Loading..",
                          style: TextStyle(color: Colors.white),
                        ),
                      SizedBox(height: 25),
                      NormalTextWidget(
                        title: "Already have an account? Log In",
                        gestureCallBack: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  registerUser() {
    Map<String, dynamic> postData = {
      "name": fullNameTEC.text,
      "emiratesid": "784-1986-36240477",
      "passportnumber": passportTEC.text,
      "mobilenumber": phoneNumberTEC.text,
      "emailid": "demo@aa.ae",
      "dateofbirth": 1586775847000,
      "languageid": 1033,
      "mobileapplicationid": 69,
      "mobileostype": 1,
    };
    print(postData);
    print("Register Success");

    dynamic data = NetworkApiService().registerUser(postData);
    print(data);
    setState(() {
      showLoader = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LogInScreen(),
      ),
    );
  }
}
