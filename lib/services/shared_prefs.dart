import 'dart:convert';
import 'package:final_app_flutter/model/account_model.dart';
import 'package:final_app_flutter/model/shoes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //Shared preferences login account
  Future<List<AccountModel>?> getAccount() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('account');
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<AccountModel> account =
        maps.map((e) => AccountModel.fromJson(e)).toList();
    return account;
  }

  Future<void> addAccount(List<AccountModel> account) async {
    List<Map<String, dynamic>> maps = account.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('account', jsonEncode(maps));
  }

  //Shared preferences signup account
  Future<List<AccountModel>?> getSignup() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('signup');
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<AccountModel> signup =
        maps.map((e) => AccountModel.fromJson(e)).toList();
    return signup;
  }

  Future<void> addSignup(List<AccountModel> signup) async {
    List<Map<String, dynamic>> maps = signup.map((e) => e.toJson()).toList();
    SharedPreferences prefs = await _prefs;
    prefs.setString('signup', jsonEncode(maps));
  }

//shared prefferences imagePick
  Future<String?> getImagePath() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString('imagePath');
  }

  Future<void> setImagePath(String imagePath) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('imagePath', imagePath);
  }

  //shared prefferences cartIterm
  Future<List<ShoesModel>?> getCart() async {
    SharedPreferences prefs = await _prefs;
    String? data = prefs.getString('cartLists');
    if (data == null) return null;
    List<Map<String, dynamic>> maps = jsonDecode(data)
        .cast<Map<String, dynamic>>() as List<Map<String, dynamic>>;
    List<ShoesModel> cartLists =
        maps.map((e) => ShoesModel.fromJson(e)).toList();
    return cartLists;
  }
  
  Future<void> saveCart(List<ShoesModel> cartItems) async {
    SharedPreferences prefs = await _prefs;
    List<Map<String, dynamic>> maps = cartItems.map((e) => e.toJson()).toList();
    prefs.setString('cartLists', jsonEncode(maps));
  }
}
