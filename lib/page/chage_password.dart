import 'dart:io';
import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/app_elevent_button.dart';
import 'package:final_app_flutter/components/app_text_field.dart';
import 'package:final_app_flutter/form_validator/form_validator.dart';
import 'package:final_app_flutter/model/account_model.dart';
import 'package:final_app_flutter/page/login_page.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:final_app_flutter/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController changePasswordController = TextEditingController();

  bool _isPasswordVisible = true;
  final provider = FormValidator();
  final _formKey = GlobalKey<FormState>();

  final SharedPrefs _prefs = SharedPrefs();
  AccountModel account = AccountModel();
  File? _image;

  @override
  void initState() {
    for (var acc in accountList1) {
      setState(() {
        account = acc;
      });
    }
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        showAvatar: false,
        title: '',
        leftPressed: () {
          Route route = PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MainTabPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return child;
            },
          );
          Navigator.push(context, route);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30.0),
                Text(
                  'Change Password',
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Email Address',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppTextField(
                  readOnly: true,
                  controller: emailAddressController =
                      TextEditingController(text: account.emailAddress),
                  hintText: 'Email Address',
                  iconData: Icons.email,
                  textInputAction: TextInputAction.next,
                  validator: (value) => provider.emailValidator(value!),
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  iconData: Icons.lock,
                  isPassword: _isPasswordVisible,
                  iconPass: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onPass: _togglePasswordVisibility,
                  validator: (value) => provider.passwordValidator(value!),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30.0),
                Text(
                  'New Password',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppTextField(
                  controller: newPasswordController,
                  hintText: 'New Password',
                  iconData: Icons.lock,
                  isPassword: _isPasswordVisible,
                  iconPass: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onPass: _togglePasswordVisibility,
                  validator: (value) => provider.passwordValidator(value!),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Repeat Password',
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AppTextField(
                  controller: changePasswordController,
                  hintText: 'Repeat Password',
                  iconData: Icons.lock,
                  isPassword: _isPasswordVisible,
                  iconPass: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onPass: _togglePasswordVisibility,
                  validator: (value) => provider.confirmPass(
                    value!,
                    newPasswordController.text,
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 40.0),
                AppEleventButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(account.emailAddress);
                      print(account.password);
                      if (emailAddressController.text == account.emailAddress &&
                          passwordController.text == account.password) {
                        setState(() {
                          // Xóa dữ liệu cũ
                          accountList.clear();
                          // Cập nhật thông tin tài khoản với mật khẩu mới
                          account.password = newPasswordController.text;
                          accountList.add(account);
                        });

                        // Lưu lại danh sách tài khoản mới vào Shared Preferences
                        _prefs.addSignup(accountList);
                        accountList1.clear();
                        _prefs.addAccount(accountList1);
                        // Hiển thị snackbar và chuyển đến trang đăng nhập
                        final snackBar = SnackBar(
                          content: Text("Change password success!"),
                          backgroundColor: AppColor.grey,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Route route = MaterialPageRoute(
                          builder: (context) => LoginPage(
                            email: emailAddressController.text,
                          ),
                        );
                        Navigator.push(context, route);
                      } else {
                        // Hiển thị thông báo khi mật khẩu cũ không đúng
                        final snackBar = SnackBar(
                          content: Text("Incorrect old password"),
                          backgroundColor: AppColor.grey,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  text: 'Change Password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
