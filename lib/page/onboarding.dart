import 'package:final_app_flutter/components/app_elevent_button.dart';
import 'package:final_app_flutter/model/content_onboard.dart';
import 'package:final_app_flutter/page/login_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0)
                            .copyWith(bottom: 50.0),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image ?? "",
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              contents[i].title ?? "",
                              style: const TextStyle(
                                fontSize: 37.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              contents[i].discription ?? "",
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: AppColor.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 30,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  contents.length,
                  (index) => BuildDot(index, context),
                ),
                const SizedBox(width: 130.0),
                AppEleventButton(
                  width: 100.0,
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  text: currentIndex == contents.length - 1
                      ? "Get Started"
                      : "Next",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container BuildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColor.blue),
    );
  }
}
