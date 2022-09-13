import 'package:flutter/material.dart';
import 'package:flutter_paisa/app/routes.dart';
import 'package:flutter_paisa/common/constants/currency.dart';
import 'package:flutter_paisa/common/enum/box_types.dart';
import 'package:flutter_paisa/common/widgets/material_you_app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paisa/data/goals/model/goal.dart';

class GoalsListPage extends StatefulWidget {
  const GoalsListPage({super.key});

  @override
  State<GoalsListPage> createState() => _GoalsListPageState();
}

class _GoalsListPageState extends State<GoalsListPage> {
  late final goals = Hive.box<Goal>(BoxType.goals.stringValue);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: materialYouAppBar(
        context,
        AppLocalizations.of(context)!.goalsLable,
      ),
      body: ValueListenableBuilder<Box<Goal>>(
        valueListenable: Hive.box<Goal>(BoxType.goals.stringValue).listenable(),
        builder: (_, value, __) {
          final goals = value.values.toList();
          if (goals.isEmpty) {
            return Text('data');
          }
          return ListView.builder(
            itemCount: goals.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return ListTile(
                onTap: () => context.pushNamed(
                  goalDetailsPath,
                  extra: goals[index],
                ),
                title: Text(goals[index].title),
                subtitle: Text(
                  'Goal: ${formattedCurrency(goals[index].amount)}',
                  style: GoogleFonts.manrope(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          final goal = Goal(
            amount: 23344,
            description: 'Demo Goal',
            endTime: DateTime.now().add(const Duration(days: 30)),
            title: 'Buy car',
          );
          final int id = await goals.add(goal);
          goal.superId = id;
          goal.save();
        },
        tooltip: AppLocalizations.of(context)!.addExpenseLable,
        heroTag: 'add_expense',
        key: const Key('add_expense'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
