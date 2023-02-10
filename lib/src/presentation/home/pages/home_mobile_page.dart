import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/common.dart';
import '../../search/pages/search_page.dart';
import '../../widgets/filter_widget/paisa_filter_transaction_widget.dart';
import '../../widgets/paisa_user_widget.dart';
import '../bloc/home_bloc.dart';
import '../widgets/content_widget.dart';

class HomeMobilePage extends StatelessWidget {
  const HomeMobilePage({
    super.key,
    required this.homeBloc,
    required this.dateTimeRangeNotifier,
    required this.floatingActionButton,
  });
  final HomeBloc homeBloc;
  final Widget floatingActionButton;
  final ValueNotifier<DateTimeRange?> dateTimeRangeNotifier;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: false,
                snap: true,
                floating: true,
                leading: const SizedBox.shrink(),
                actions: [
                  const PaisaFilterTransactionWidget(),
                  PaisaUserWidget(homeBloc: homeBloc),
                ],
                scrolledUnderElevation: 0,
                elevation: 0,
                leadingWidth: 0,
                titleSpacing: 0,
                title: ListTile(
                  horizontalTitleGap: 0,
                  title: Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchPage(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  context.loc.appBarSearchLabel,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: ContentWidget(
            dateTimeRangeNotifier: dateTimeRangeNotifier,
          ),
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) => Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
            ),
            child: NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedIndex: homeBloc.getIndexFromPage(homeBloc.currentPage),
              onDestinationSelected: (index) => homeBloc
                  .add(CurrentIndexEvent(homeBloc.getPageFromIndex(index))),
              destinations: [
                NavigationDestination(
                  label: context.loc.homeLabel,
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                ),
                NavigationDestination(
                  label: context.loc.accountsLabel,
                  icon: const Icon(Icons.credit_card_outlined),
                  selectedIcon: const Icon(Icons.credit_card),
                ),
                NavigationDestination(
                  label: context.loc.categoryLabel,
                  icon: const Icon(Icons.category_outlined),
                  selectedIcon: const Icon(Icons.category),
                ),
                NavigationDestination(
                  label: context.loc.budgetLabel,
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  selectedIcon: const Icon(Icons.account_balance_wallet),
                ),
              ],
            ),
          ),
        ),
      );
}
