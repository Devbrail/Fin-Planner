import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/common.dart';
import '../../../core/enum/card_type.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({
    Key? key,
    required this.totalBalance,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    required this.income,
    required this.expense,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final String totalBalance;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final String income, expense;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileAccountCard(
        bankName: widget.bankName,
        cardHolder: widget.cardHolder,
        totalBalance: widget.totalBalance,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
        expense: widget.expense,
        income: widget.income,
      ),
      tablet: TabletAccountCard(
        bankName: widget.bankName,
        cardHolder: widget.cardHolder,
        cardNumber: widget.totalBalance,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
        expense: widget.expense,
        income: widget.income,
      ),
      desktop: DesktopAccountCard(
        bankName: widget.bankName,
        cardHolder: widget.cardHolder,
        cardNumber: widget.totalBalance,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
        expense: widget.expense,
        income: widget.income,
      ),
    );
  }
}

class MobileAccountCard extends StatelessWidget {
  const MobileAccountCard({
    Key? key,
    required this.totalBalance,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
    required this.income,
    required this.expense,
  }) : super(key: key);

  final String totalBalance;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final String income, expense;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassmorphicContainer(
          height: 240,
          width: MediaQuery.of(context).size.width,
          borderRadius: 24,
          blur: 10,
          alignment: Alignment.bottomCenter,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
            ],
          ),
          border: 2,
          child: Column(
            children: [
              ListTile(
                minVerticalPadding: 10,
                horizontalTitleGap: 0,
                title: Text(bankName, style: GoogleFonts.outfit()),
                subtitle: Text(cardHolder, style: GoogleFonts.outfit()),
                leading: Icon(cardType.icon),
                trailing: onDelete != null
                    ? GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const Spacer(),
              ListTile(
                minVerticalPadding: 10,
                title: Text(
                  context.loc.totalBalance,
                  style: GoogleFonts.outfit(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                subtitle: Text(
                  totalBalance,
                  style: GoogleFonts.manrope(
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        context.loc.income,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.75),
                        ),
                      ),
                      subtitle: Text(
                        income,
                        style: GoogleFonts.manrope(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        context.loc.expense,
                        style: GoogleFonts.outfit(
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                        .withOpacity(0.75),
                                  ),
                        ),
                      ),
                      subtitle: Text(
                        expense,
                        style: GoogleFonts.manrope(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabletAccountCard extends StatelessWidget {
  const TabletAccountCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
    required this.income,
    required this.expense,
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final String income, expense;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassmorphicContainer(
          height: 240,
          width: MediaQuery.of(context).size.width / 2,
          borderRadius: 24,
          blur: 10,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                title: Text(bankName.toUpperCase()),
                subtitle: Text(cardHolder.toUpperCase()),
                leading: Icon(cardType.icon),
                trailing: onDelete != null
                    ? GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.loc.totalBalance,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          cardNumber,
                          style: GoogleFonts.manrope(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.income,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                          .withOpacity(0.75),
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            income,
                            style: GoogleFonts.manrope(
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.expense,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                          .withOpacity(0.75),
                                    ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            expense,
                            style: GoogleFonts.manrope(
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopAccountCard extends StatelessWidget {
  const DesktopAccountCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
    required this.income,
    required this.expense,
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final String income, expense;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassmorphicContainer(
          height: 240,
          width: MediaQuery.of(context).size.width / 2,
          borderRadius: 24,
          blur: 10,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.5),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                horizontalTitleGap: 0,
                title: Text(bankName.toUpperCase()),
                subtitle: Text(cardHolder.toUpperCase()),
                leading: Icon(cardType.icon),
                trailing: onDelete != null
                    ? GestureDetector(
                        onTap: onDelete,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.loc.totalBalance),
                        Text(
                          cardNumber,
                          style: GoogleFonts.manrope(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  bottom: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.income,
                            style: GoogleFonts.manrope(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                        .withOpacity(0.75),
                                  ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            income,
                            style: GoogleFonts.manrope(
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.loc.expense,
                            style: GoogleFonts.manrope(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                        .withOpacity(0.75),
                                  ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            expense,
                            style: GoogleFonts.manrope(
                              textStyle: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
