import 'package:final_app_flutter/components/app_bar.dart';
import 'package:final_app_flutter/page/main_tab_page.dart';
import 'package:final_app_flutter/page/my_cart_page.dart';
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../components/app_elevent_button.dart';
import '../model/shoes_model.dart';
import '../services/shared_prefs.dart';

class ShoesDetailPage extends StatefulWidget {
  final ShoesModel shoe;

  const ShoesDetailPage({Key? key, required this.shoe}) : super(key: key);

  @override
  State<ShoesDetailPage> createState() => _ShoesDetailPageState();
}

class _ShoesDetailPageState extends State<ShoesDetailPage> {
  final SharedPrefs _prefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  _loadCartData() async {
    List<ShoesModel>? savedCart = await _prefs.getCart();
    if (savedCart != null) {
      setState(() {
        cartItems = savedCart;
      });
    }
  }

  _saveCartData() async {
    await _prefs.saveCart(cartItems);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: TdAppBar(
        showAvatar: false,
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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            widget.shoe.imageStr.toString(),
            width: media.width,
            height: media.width,
            fit: BoxFit.fill,
          ),
          Container(
            width: media.width,
            height: media.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: media.width - 60,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                widget.shoe.name.toString(),
                                style: const TextStyle(
                                    color: AppColor.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: IgnorePointer(
                                ignoring: true,
                                child: RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColor.red,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    '\$',
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.shoe.price.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: AppColor.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     Text(
                                  //       widget.shoe.description.toString(),
                                  //       style: const TextStyle(
                                  //           color: AppColor.black,
                                  //           fontSize: 18,
                                  //           fontWeight: FontWeight.w700),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                widget.shoe.description.toString(),
                                style: const TextStyle(
                                    color: AppColor.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  const Text(
                                    "Size :",
                                    style: TextStyle(
                                        color: AppColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius:
                                              BorderRadius.circular(26),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColor.grey
                                                  .withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          widget.shoe.size.toString(),
                                          style: const TextStyle(
                                              color: AppColor.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Price",
                                        style: TextStyle(
                                            color: AppColor.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // const SizedBox(
                                      //   height: 15,
                                      // ),
                                      Text(
                                        "\$${widget.shoe.price.toString()}",
                                        style: const TextStyle(
                                            color: AppColor.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  AppEleventButton( 
                                    onPressed: () async {
                                      bool isDuplicate = cartItems.any(
                                          (item) => item.id == widget.shoe.id);

                                      setState(() {
                                        if (isDuplicate) {
                                          // Tìm sản phẩm trùng và tăng số lượng
                                          cartItems = cartItems.map((item) {
                                            if (item.id == widget.shoe.id) {
                                              item.quantity =
                                                  (item.quantity ?? 1) + 1;
                                            }
                                            return item;
                                          }).toList();
                                        } else {
                                          // Thêm sản phẩm mới vào giỏ hàng
                                          cartItems.add(widget.shoe);
                                        }
                                      });

                                      await _saveCartData();
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MyCartPage(),
                                          ));
                                    },
                                    text: "Add to Cart",
                                    colorBorder: AppColor.blue,
                                    width: 150,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
