import 'package:flutter/material.dart';
import 'package:flutter_health/widgets/health_status_widget.dart';
import 'package:flutter_health/widgets/round_rect_button_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1A244f),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/logo.png", width: 70, height: 70),
              Text(
                "SELF-QUARANTINE",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                child: Text(
                  "What is your current health condition?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue, width: 2),
                  image: DecorationImage(
                    image: AssetImage("assets/images/positive.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                width: 330,
                height: 95,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "I was tested and my results were positive",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        width: 200,
                      ),
                      Text(
                        "COVID-19 Positive",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              HealthStatusWidget(
                imagePath: "assets/images/negative.png",
                headLine: "COVID-19 Negative",
                description: "I was tested and my results were negative",
              ),
              SizedBox(height: 10),
              HealthStatusWidget(
                imagePath: "assets/images/symptoms.png",
                headLine: "COVID-19 Symptoms",
                description:
                    "I haven't been tested but I have COVID-19 symptoms",
              ),
              SizedBox(height: 10),
              HealthStatusWidget(
                imagePath: "assets/images/quarantine.png",
                headLine: "COVID-19 Quarantine",
                description: "I want to put myself under self-quarantine",
              ),
              SizedBox(height: 10),
              RoundRectButtonWidget(
                title: "Submit",
                gestureCallBack: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
