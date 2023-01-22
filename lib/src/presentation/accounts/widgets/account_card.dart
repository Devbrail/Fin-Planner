import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../core/enum/card_type.dart';
import '../../../lava/lava_clock.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
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
        cardNumber: widget.cardNumber,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
      ),
      tablet: TabletAccountCard(
        bankName: widget.bankName,
        cardHolder: widget.cardHolder,
        cardNumber: widget.cardNumber,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
      ),
      desktop: DesktopAccountCard(
        bankName: widget.bankName,
        cardHolder: widget.cardHolder,
        cardNumber: widget.cardNumber,
        cardType: widget.cardType,
        onDelete: widget.onDelete,
        onTap: widget.onTap,
      ),
    );
  }
}

class MobileAccountCard extends StatelessWidget {
  const MobileAccountCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.bankName,
    required this.cardType,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
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
          border: 2,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.1),
              Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
              Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bankName.toUpperCase(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Icon(cardType.icon),
                  ],
                ),
                cardNumber.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RichText(
                          text: TextSpan(
                            text: '**** ',
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: Theme.of(context).textTheme.headline5,
                            ),
                            children: [
                              const TextSpan(text: '**** '),
                              const TextSpan(text: '**** '),
                              TextSpan(
                                  text:
                                      cardNumber.isEmpty ? '----' : cardNumber)
                            ],
                          ),
                        ),
                      ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!
                                .cardholderLabel
                                .toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .color!
                                    .withOpacity(0.5),
                                fontSize: 9,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            cardHolder.toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          )
                        ],
                      ),
                    ),
                    onDelete != null
                        ? IconButton(
                            onPressed: onDelete,
                            icon: const Icon(Icons.delete),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
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
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'account',
      child: LavaAnimation(
        child: GestureDetector(
          onTap: onTap,
          child: GlassmorphicContainer(
            height: 500,
            width: MediaQuery.of(context).size.width,
            borderRadius: 16,
            blur: 10,
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.1),
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.05),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankName,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Icon(cardType.icon, size: 32),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: '**** ',
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: Theme.of(context).textTheme.subtitle1,
                      ),
                      children: [
                        const TextSpan(text: '**** '),
                        const TextSpan(text: '**** '),
                        TextSpan(text: cardNumber.isEmpty ? '----' : cardNumber)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!
                            .cardholderLabel
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.caption?.copyWith(),
                      ),
                      Text(
                        cardHolder.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
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
  }) : super(key: key);

  final String cardNumber;
  final String cardHolder;
  final String bankName;
  final CardType cardType;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'account',
      child: LavaAnimation(
        child: GestureDetector(
          onTap: onTap,
          child: GlassmorphicContainer(
            height: 450,
            width: MediaQuery.of(context).size.width,
            borderRadius: 16,
            blur: 10,
            alignment: Alignment.bottomCenter,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.1),
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.05),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
                Theme.of(context).textTheme.subtitle1!.color!.withOpacity(0.5),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bankName,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Icon(cardType.icon, size: 32),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: '**** ',
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: Theme.of(context).textTheme.headline2,
                      ),
                      children: [
                        const TextSpan(text: '**** '),
                        const TextSpan(text: '**** '),
                        TextSpan(text: cardNumber.isEmpty ? '----' : cardNumber)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!
                            .cardholderLabel
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .color!
                                  .withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        cardHolder.toUpperCase(),
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
