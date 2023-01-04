import 'package:flutter/material.dart';

import '../search/pages/search_page.dart';

class PaisaSearchButtonWidget extends StatelessWidget {
  const PaisaSearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.search,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      onPressed: () {
        showSearch(
          context: context,
          delegate: SearchPage(),
        );
      },
    );
  }
}
