// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

import 'package:paisa/src/data/accounts/model/account_model.dart';
import 'package:paisa/src/data/category/model/category_model.dart';
import 'package:paisa/src/data/expense/model/expense_model.dart';

class Data {
  Data({
    required this.expenses,
    required this.accounts,
    required this.categories,
  });

  final List<ExpenseModel> expenses;
  final List<AccountModel> accounts;
  final List<CategoryModel> categories;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        expenses: List<ExpenseModel>.from(
            json["expenses"].map((x) => ExpenseModel.fromJson(x))),
        accounts: List<AccountModel>.from(
            json["accounts"].map((x) => AccountModel.fromJson(x))),
        categories: List<CategoryModel>.from(
            json["categories"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class AccountEntity {
  AccountEntity({
    required this.name,
    required this.bankName,
    required this.icon,
    required this.validThru,
    required this.number,
    required this.cardType,
    required this.superId,
  });

  final String name;
  final String bankName;
  final String icon;
  final DateTime validThru;
  final String number;
  final String cardType;
  final int superId;

  factory AccountEntity.fromRawJson(String str) =>
      AccountEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountEntity.fromJson(Map<String, dynamic> json) => AccountEntity(
        name: json["name"],
        bankName: json["bankName"],
        icon: json["icon"],
        validThru: DateTime.parse(json["validThru"]),
        number: json["number"],
        cardType: json["cardType"],
        superId: json["superId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bankName": bankName,
        "icon": icon,
        "validThru": validThru.toIso8601String(),
        "number": number,
        "cardType": cardType,
        "superId": superId,
      };
}

class CategoryEntity {
  CategoryEntity({
    required this.name,
    required this.description,
    required this.icon,
    required this.superId,
    required this.budget,
  });

  final String name;
  final String description;
  final String icon;
  final int superId;
  final int budget;

  factory CategoryEntity.fromRawJson(String str) =>
      CategoryEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => CategoryEntity(
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        superId: json["superId"],
        budget: json["budget"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "icon": icon,
        "superId": superId,
        "budget": budget,
      };
}

class ExpenseEntity {
  ExpenseEntity({
    required this.name,
    required this.currency,
    required this.time,
    required this.type,
    required this.accountId,
    required this.categoryId,
    required this.superId,
  });

  final String name;
  final String currency;
  final DateTime time;
  final String type;
  final int accountId;
  final int categoryId;
  final int superId;

  factory ExpenseEntity.fromRawJson(String str) =>
      ExpenseEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExpenseEntity.fromJson(Map<String, dynamic> json) => ExpenseEntity(
        name: json["name"],
        currency: json["currency"],
        time: DateTime.parse(json["time"]),
        type: json["type"],
        accountId: json["accountId"],
        categoryId: json["categoryId"],
        superId: json["superId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "currency": currency,
        "time": time.toIso8601String(),
        "type": type,
        "accountId": accountId,
        "categoryId": categoryId,
        "superId": superId,
      };
}
