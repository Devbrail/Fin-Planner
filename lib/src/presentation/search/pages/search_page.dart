import 'package:flutter/material.dart';

import '../../../data/expense/model/expense_model.dart';
import '../widgets/search_list_widget.dart';

class SearchPage extends SearchDelegate<ExpenseModel?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // for closing the search page and going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchListWidget(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchListWidget(query: query);
  }
}
