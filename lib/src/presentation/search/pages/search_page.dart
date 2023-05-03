import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../../data/accounts/model/account_model.dart';
import '../../../data/category/model/category_model.dart';
import '../../../domain/account/entities/account.dart';
import '../../../domain/category/entities/category.dart';
import '../../expense/widgets/selectable_item_widget.dart';
import '../../summary/widgets/expense_list_widget.dart';
import '../../widgets/paisa_big_button_widget.dart';
import '../../widgets/paisa_card.dart';
import '../cubit/search_cubit_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit searchCubitCubit = getIt.get();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: PaisaFilledCard(
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                    filled: false,
                    hintText: context.loc.searchLabel,
                  ),
                  controller: textEditingController,
                  onChanged: (value) {
                    searchCubitCubit.searchWithQuery(value);
                  },
                ),
              ),
              IconButton(
                onPressed: () async {
                  final Map<String, dynamic> result =
                      await showModalBottomSheet(
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
                          selectedAccount: searchCubitCubit.selectedAccountId,
                          selectedCategory: searchCubitCubit.selectedCategoryId,
                        ),
                      );
                    },
                  );
                  searchCubitCubit.selectedAccountId = result['category'];
                  searchCubitCubit.selectedCategoryId = result['account'];
                  searchCubitCubit.searchWithQuery(textEditingController.text);
                },
                icon: Icon(
                  MdiIcons.filter,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 8)
            ],
          ),
        ),
      ),
      body: BlocBuilder(
        bloc: searchCubitCubit,
        builder: (context, state) {
          if (state is SearchResultState) {
            return SingleChildScrollView(
                child: ExpenseListWidget(expenses: state.expenses));
          } else if (state is SearchQueryEmptyState) {
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
          } else if (state is SearchEmptyState) {
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
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  final ScrollController scrollController;
  final int selectedAccount, selectedCategory;
  const FilterWidget(
    this.scrollController, {
    super.key,
    required this.selectedAccount,
    required this.selectedCategory,
  });

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late int selectedAccount = widget.selectedAccount;
  late int selectedCategory = widget.selectedCategory;
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
                    isSelected: selectedAccount == account.superId!,
                    title: account.name,
                    icon: account.icon,
                    onPressed: () {
                      setState(() {
                        selectedAccount = account.superId!;
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
            final categories = value.values.toEntities();
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
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  final Category category = categories[index];
                  return ItemWidget(
                    isSelected: selectedCategory == category.superId!,
                    title: category.name,
                    icon: category.icon,
                    onPressed: () {
                      setState(() {
                        selectedCategory = category.superId!;
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PaisaTextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    {
                      'account': -1,
                      'category': -1,
                    },
                  );
                },
                title: 'Clear',
              ),
              PaisaButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    {
                      'account': selectedAccount,
                      'category': selectedCategory,
                    },
                  );
                },
                title: 'Done',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
