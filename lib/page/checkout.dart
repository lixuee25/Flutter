import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/components/checkout_item.dart';
import 'package:final_app_flutter/page/my_cart_page.dart';
import 'package:final_app_flutter/page/order_success.dart';
import 'package:flutter/material.dart';
import '../components/app_elevent_button.dart';
import '../model/shoes_model.dart';
import '../resources/app_color.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage(
      {Key? key,
      required this.name,
      required this.phone,
      required this.address})
      : super(key: key);
  final String name;
  final String phone;
  final String address;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  double get totalPrice {
    double sum = 0.0;
    for (var shoe in cartItems) {
      sum += shoe.total;
    }
    return sum;
  }

  int _type = 1;

  void _handleRadio(Object? e) {
    setState(() {
      _type = e as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        showAvatar: false,
        title: 'Check Out',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: MediaQuery.of(context).padding.top + 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              const Text(
                "Shipping Address",
                // textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.blue,
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Name: ${widget.name}',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Phone: ${widget.phone}',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        'Address: ${widget.address}',
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30.0),
              const Text(
                "Product",
                // textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final shoes_item = cartItems[index];
                  return CheckoutItem(
                    shoes_item,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20.0),
                itemCount: cartItems.length,
              ),
              // Divider(color: AppColor.grey.withOpacity(0.5), thickness: 0.5),
              const SizedBox(height: 20.0),

              const Text(
                "Payment method",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Container(
                width: 400,
                height: 55,
                // margin: EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  border: _type == 1
                      ? Border.all(width: 1, color: const Color(0xFFDB3022))
                      : Border.all(width: 0.3, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _type,
                          onChanged: _handleRadio,
                          activeColor: const Color(0xFFDB3022),
                        ),
                        Text("Pay with cash",
                            style: _type == 1
                                ? const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)
                                : const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Price: ',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    '\$',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    totalPrice.toStringAsFixed(1),
                    style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              AppEleventButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderSuccess(),
                        ));
                  },
                  text: "Payment",
                  colorBorder: AppColor.blue),
            ],
          ),
        ),
      ),
    );
  }
}
