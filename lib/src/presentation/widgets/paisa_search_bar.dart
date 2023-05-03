import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/common.dart';

class PaisaSearchBar extends StatelessWidget {
  const PaisaSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 256),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(34),
        onTap: () {
          GoRouter.of(context).pushNamed(search);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.search_rounded),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(context.loc.searchLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
