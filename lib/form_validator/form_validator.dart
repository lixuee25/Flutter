import 'package:flutter/material.dart';

class FormValidator extends ChangeNotifier {
  bool _isvisible = false;

  // Strong password requirement
  // Password requirement: at least 6 characters
  RegExp strongPassword = RegExp(r'^.{6,}$');

  // Validated Email format
  RegExp emailRequirement = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Phone number validator
  phoneValidator(String value) {
    if (value.isEmpty) {
      return "Phone is required";
    } else if (value.length < 10) {
      return "Phone number is not valid";
    } else {
      return null;
    }
  }

  // General Validator
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  // Password validator | Strong password
  passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password is required";
    } else if (!strongPassword.hasMatch(value)) {
      return "Password is not a six-digit number";
    } else {
      return null;
    }
  }

  // Confirm password
  confirmPass(String value1, String value2) {
    if (value1.isEmpty) {
      return "Re-enter your password";
    } else if (value1 != value2) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  // Email validator
  emailValidator(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (!emailRequirement.hasMatch(value)) {
      return "Email is not valid";
    } else {
      return null;
    }
  }

  showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)));
  }
}
