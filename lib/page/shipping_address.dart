import 'package:flutter/material.dart';
import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/app_elevent_button.dart';
import 'package:final_app_flutter/components/app_text_field.dart';
import 'package:final_app_flutter/page/checkout.dart';
import 'package:final_app_flutter/page/my_cart_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:final_app_flutter/form_validator/form_validator.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final provider = FormValidator(); // Thêm instance của FormValidator
  final _formKey = GlobalKey<FormState>(); // Thêm GlobalKey để quản lý form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        showAvatar: false,
        title: 'Shipping Address',
        leftPressed: () {
          Route route = PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MyCartPage(),
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
          padding:
              const EdgeInsets.symmetric(horizontal: 30.0).copyWith(top: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: nameController,
                  iconData: Icons.person,
                  hintText: 'Name',
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      provider.validator(value!, "Name is required"),
                ),
                const SizedBox(height: 15.0),
                AppTextField(
                  controller: phoneController,
                  iconData: Icons.phone,
                  hintText: 'Phone',
                  textInputAction: TextInputAction.next,
                  validator: (value) => provider.phoneValidator(value!),
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: addressController,
                  iconData: Icons.business,
                  hintText: 'Address',
                  textInputAction: TextInputAction.done,
                  validator: (value) =>
                      provider.validator(value!, "Address is required"),
                ),
                const SizedBox(height: 15),
                AppEleventButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Nếu form hợp lệ, chuyển tới trang CheckOutPage
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOutPage(
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                            ),
                          ),
                        );
                      } else {
                        // Nếu form không hợp lệ, hiển thị snackbar
                        provider.showSnackBar(
                            "Please correct the errors", context);
                      }
                    },
                    text: "Payment",
                    colorBorder: AppColor.blue),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
