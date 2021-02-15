import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_health/screens/home_screen.dart';
import 'package:flutter_health/screens/signup_screen.dart';
import 'package:flutter_health/services/dart/network_api_service.dart';
import 'package:flutter_health/widgets/normal_text_widget.dart';
import 'package:flutter_health/widgets/round_rect_button_widget.dart';
import 'package:flutter_health/widgets/textfield_widget.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController phoneNumberTEC = TextEditingController();
  final TextEditingController otpTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isOTPSent = false;
  bool showLoader = false;

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
            height: 480,
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
                  Form(
                    key: formKey,
                    child: TextFieldWidget(
                      textEditingController: phoneNumberTEC,
                      hintText: "Mobile No.",
                      icon: Icons.phone_iphone,
                      validateFieldValue: (String value) {
                        if (value.length < 10) {
                          return "Minimum 10 digits required";
                        }
                        if (!value
                            .contains(new RegExp('(?:[+0]9)?[0-9]{10}'))) {
                          return "Only numbers are allowed";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  if (!isOTPSent)
                    Column(
                      children: [
                        RoundRectButtonWidget(
                          title: "Log In",
                          gestureCallBack: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (formKey.currentState.validate()) {
                              setState(() {
                                isOTPSent = true;
                              });
                              formKey.currentState.save();
                              loginUser();
                            }
                          },
                        ),
                        SizedBox(height: 40),
                        NormalTextWidget(
                          title: "Don't have an account? Register",
                          gestureCallBack: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Text(
                          "Enter OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Enter your 5 digit otp",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 20),
                          child: TextFormField(
                            controller: otpTEC,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            validator: (String value) {
                              return "";
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                            ],
                            decoration: InputDecoration(
                              isDense: true,
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        NormalTextWidget(
                          title: "Didn't get a code? Resend code",
                          gestureCallBack: () {
                            resendOTP();
                          },
                        ),
                        SizedBox(height: 40),
                        RoundRectButtonWidget(
                          title: "Submit",
                          gestureCallBack: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (otpTEC.text.length > 4) {
                              setState(() {
                                showLoader = true;
                              });
                              formKey.currentState.save();
                              Future.delayed(const Duration(seconds: 3), () {
                                loginUser();
                                setState(() {
                                  showLoader = false;
                                  isOTPSent = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                        if (showLoader)
                          ScalingText(
                            "Loading..",
                            style: TextStyle(color: Colors.white),
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

  loginUser() {
    print("Login User called");
    Map<String, dynamic> postData = {
      "mobilenumber": phoneNumberTEC.text,
      "languageid": 1033,
      "mobileapplicationid": 69,
      "mobileostype": 1,
      "autologin": false,
    };
    print(postData);

    dynamic data = NetworkApiService().loginUser(postData);
    print(data);
  }

  submitOTP() {
    print("Submit OTP called");
    Map<String, dynamic> postData = {
      "mobilenumber": phoneNumberTEC.text,
      "languageid": 1033,
      "mobileapplicationid": 69,
      "mobileostype": 1,
      "regionuid": "5e96e38885871511baebd7a3",
      "businessunituid": "5e945b58f30c55d22c9a7051",
      "tenantuid": "5e94733af30c55d22c9b23bc",
      "assetid": "4b1b11f3-92de-4a62-aaaa-272da7829535",
      "useruid": "5e96ee08ef803s7f4b5e7684",
    };
    print(postData);

    dynamic data = NetworkApiService().userUpdateSMSVerified(postData);
    print(data);
  }

  resendOTP() {
    print("Resend OTP called");
    Map<String, dynamic> postData = {
      "mobilenumber": phoneNumberTEC.text,
      "languageid": 1033,
      "mobileapplicationid": 69,
      "regionuid": "5e96e38885871511baebd7a3",
      "businessunituid": "5e945b58f30c55d22c9a7051",
      "tenantuid": "5e94733af30c55d22c9b23bc",
      "assetid": "4b1b11f3-92de-4a62-aaaa-272da7829535",
      "useruid": "5e96ee08ef803s7f4b5e7684",
    };
    print(postData);

    dynamic data = NetworkApiService().sendSMSTOUser(postData);
    print(data);
  }
}
