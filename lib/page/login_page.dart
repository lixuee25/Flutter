import 'dart:io';
import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/app_elevent_button.dart';
import 'package:final_app_flutter/components/app_text_field.dart';
import 'package:final_app_flutter/form_validator/form_validator.dart';
import 'package:final_app_flutter/model/account_model.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/page/sign_up_page.dart';
import 'package:final_app_flutter/services/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_app_flutter/resources/app_color.dart';

class LoginPage extends StatefulWidget {
  final String? email;
  final String? password;

  const LoginPage({Key? key, this.email, this.password}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  final provider = FormValidator();
  final _formKey = GlobalKey<FormState>();
  final SharedPrefs _prefs = SharedPrefs();
  File? _image;

  @override
  void initState() {
    super.initState();
    _emailAddressController.text = widget.email ?? '';
    _passwordController.text = widget.password ?? '';
    loadSavedImage();
  }

  Future<void> loadSavedImage() async {
    final imagePath = await _prefs.getImagePath();
    if (imagePath != null && imagePath.isNotEmpty) {
      final imageFile = File(imagePath);
      setState(() {
        _image = imageFile;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🌗 Exit!'),
          content: const Text('Do you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                Navigator.pop(context);
              },
              child: const Text('Yes 😭'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No 🥰'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        showAvatar: false,
        leftPressed: _showExitDialog,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 40.0).copyWith(top: 20.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Hello Again!',
                    style: TextStyle(
                        fontSize: 28.0,
                        color: AppColor.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Welcome Back You've Been Missed!",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: AppColor.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppTextField(
                    onChanged: (value) => {},
                    iconData: Icons.email,
                    controller: _emailAddressController,
                    hintText: 'Email Address',
                    textInputAction: TextInputAction.next,
                    validator: (value) => provider.emailValidator(value!),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppTextField(
                    iconData: Icons.lock,
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: _isPasswordVisible,
                    iconPass: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPass: _togglePasswordVisibility,
                    validator: (value) => provider.passwordValidator(value!),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 40.0),
                  AppEleventButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool accountExists = false;
                        for (var account in accountList) {
                          if (_emailAddressController.text ==
                              account.emailAddress) {
                            if (_passwordController.text == account.password) {
                              accountExists = true;
                              accountList1.add(account);
                              _prefs.addAccount(accountList1);
                              final snackBar = SnackBar(
                                content: Text("Login successful!"),
                                backgroundColor: AppColor.grey,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Route route = MaterialPageRoute(
                                builder: (context) => MainTabPage(),
                              );
                              Navigator.push(context, route);
                              break;
                            } else {
                              accountExists = true;
                              final snackBar = SnackBar(
                                content: Text(
                                    "Incorrect password. Please try again."),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                duration: const Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              break;
                            }
                          }
                        }
                        if (!accountExists) {
                          final snackBar = SnackBar(
                            content:
                                Text("Account does not exist. Please sign up."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        // Hiển thị thông báo lỗi nếu có
                        provider.showSnackBar(
                            "Please fix the errors in the form.", context);
                      }
                    },
                    text: 'Log In',
                  ),
                  const SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: accountList.isEmpty
                        ? [
                            const Text("Don't Have An Account?"),
                            GestureDetector(
                              child: Text(
                                'Sign Up For Free',
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                            ),
                          ]
                        : [],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
