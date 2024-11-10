import 'package:final_app_flutter/components/app_elevent_button.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  bool isSelectCity = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                "assets/images/success.webp",
                height: 350,
              ),
              // SizedBox(height: 10),

              const SizedBox(height: 20),
              Text(
                "Your payment is successful !",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: AppEleventButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainTabPage(),
                  ),
                );
              },
              text: 'Back To Home',
              colorbg: AppColor.blue,
            ),
          ),
        ],
      ),
    );
  }
}
