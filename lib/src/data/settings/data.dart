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
