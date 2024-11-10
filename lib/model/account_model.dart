class AccountModel {
  String? emailAddress;
  String? password;
  AccountModel({this.password, this.emailAddress});

  AccountModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {'emailAddress': emailAddress, 'password': password};
  }
}

// accountList is account signed up
List<AccountModel> accountList = [];

// accountList1 is used to check login
List<AccountModel> accountList1 = [];
