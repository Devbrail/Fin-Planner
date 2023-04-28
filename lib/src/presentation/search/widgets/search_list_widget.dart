import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:paisa/src/data/accounts/model/account_model.dart';
import 'package:paisa/src/data/category/model/category_model.dart';
import 'package:paisa/src/domain/account/entities/account.dart';
import 'package:paisa/src/domain/category/entities/category.dart';
import 'package:paisa/src/presentation/expense/widgets/select_account_widget.dart';
import 'package:paisa/src/presentation/expense/widgets/selectable_item_widget.dart';
import 'package:paisa/src/presentation/widgets/paisa_big_button_widget.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/expense/model/expense_model.dart';
import '../../../domain/expense/entities/expense.dart';
import '../../summary/widgets/expense_list_widget.dart';

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({
    Key? key,
    required this.query,
  }) : super(key: key);

  final String query;

  @override
  State<SearchListWidget> createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {
  late List<Expense> results;
  int selecteAccount = -1;
  int selecteCategory = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            final Map<String, dynamic> result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width >= 700
                    ? 700
                    : double.infinity,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.2,
                  maxChildSize: 0.75,
                  expand: false,
                  builder: (context, scrollController) => FilterWidget(
                    scrollController,
                    selecteAccount: selecteAccount,
                    selecteCategory: selecteCategory,
                  ),
                );
              },
            );
            selecteAccount = result['category'];
            selecteCategory = result['account'];
            setState(() {});
          },
          icon: const Icon(MdiIcons.filter),
        ),
        ValueListenableBuilder<Box<ExpenseModel>>(
          valueListenable: getIt.get<Box<ExpenseModel>>().listenable(),
          builder: (context, value, child) {
            if (widget.query.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      size: 72,
                    ),
                    Text(context.loc.searchMessageLabel),
                  ],
                ),
              );
            }

            results = value.search(
              widget.query,
              selecteCategoryId: selecteCategory,
              selectedAccountId: selecteAccount,
            );
            if (results.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sentiment_satisfied_rounded,
                      size: 72,
                    ),
                    Text(context.loc.emptySearchMessageLabel),
                  ],
                ),
              );
            } else {
              return ExpenseListWidget(expenses: results);
            }
          },
        ),
      ],
    );
  }
}

class FilterWidget extends StatefulWidget {
  final ScrollController scrollController;
  final int selecteAccount, selecteCategory;
  const FilterWidget(
    this.scrollController, {
    super.key,
    required this.selecteAccount,
    required this.selecteCategory,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late int selecteAccount = widget.selecteAccount;
  late int selecteCategory = widget.selecteCategory;
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        ListTile(
          title: Text(
            'Filter',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.loc.selectAccountLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ValueListenableBuilder<Box<AccountModel>>(
          valueListenable: getIt.get<Box<AccountModel>>().listenable(),
          builder: (context, value, child) {
            final accounts = value.values.toEntities();
            return SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: accounts.length,
                itemBuilder: (_, index) {
                  final Account account = accounts[index];
                  return ItemWidget(
                    isSelected: selecteAccount == account.superId!,
                    title: account.name,
                    icon: account.icon,
                    onPressed: () {
                      setState(() {
                        selecteAccount = account.superId!;
                      });
                    },
                    subtitle: account.bankName,
                  );
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.loc.selectCategoryLabel,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: getIt.get<Box<CategoryModel>>().listenable(),
          builder: (context, value, child) {
            final categoies = value.values.toEntities();
            return SizedBox(
              height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categoies.length,
                itemBuilder: (_, index) {
                  final Category category = categoies[index];
                  return ItemWidget(
                    isSelected: selecteCategory == category.superId!,
                    title: category.name,
                    icon: category.icon,
                    onPressed: () {
                      setState(() {
                        selecteCategory = category.superId!;
                      });
                    },
                    subtitle: category.description,
                  );
                },
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PaisaBigButton(
            onPressed: () {
              Navigator.pop(
                context,
                {
                  'account': selecteAccount,
                  'category': selecteCategory,
                },
              );
            },
            title: 'Done',
          ),
        ),
      ],
    );
  }
}
